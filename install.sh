#!/bin/bash

set -e # Exit immediately on error

# Color codes for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_success() { echo -e "${GREEN}✔️  $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }

# Check if running with --dry-run flag
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  print_info "Running in dry-run mode - no actual changes will be made"
fi

# Early check for dotfiles directory
if [ ! -d "$HOME/dotfiles" ]; then
  print_error "~/dotfiles directory not found! Please clone your dotfiles repository first."
  echo "Example: git clone <your-dotfiles-repo> ~/dotfiles"
  exit 1
fi

print_info "Checking for yay..."
if ! command -v yay &>/dev/null; then
  print_warning "yay not found. Installing yay..."
  if [[ "$DRY_RUN" == "false" ]]; then
    sudo pacman -Sy --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si)
  else
    echo "[DRY RUN] Would install yay"
  fi
else
  print_success "yay is already installed."
fi

print_info "Installing dependencies..."

# Package groups for better organization
declare -A package_groups=(
  ["Desktop Environment"]="hyprland hyprpolkitagent qt5-wayland qt6-wayland xdg-desktop-portal-hyprland qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg"
  ["System Utilities"]="brightnessctl btop fastfetch fd git ntfs-3g stow tmux unzip yazi yt-dlp bottom pulsemixer gvfs 7zip"
  ["Audio/Video"]="pipewire pipewire-alsa pipewire-jack pipewire-pulse pavucontrol cava mpv gst-plugins-bad"
  ["Development"]="cmake code neovim typst"
  ["Applications"]="anki bleachbit gimp gnome-calculator obsidian steam vesktop zathura zathura-pdf-poppler localsend-bin"
  ["Fonts"]="noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nerd-fonts"
  ["Theming/Customization"]="matugen-bin oh-my-posh spicetify-cli nwg-look gtk-engine-murrine gnome-themes-extra sassc capitaine-cursors"
  ["Networking/Bluetooth"]="bluetui bluez bluez-deprecated-tools bluez-utils nm-connection-editor"
  ["AUR Packages"]="ani-cli-git brave-nightly-bin spotify switcheroo overskride"
  ["Wayland/UI"]="waybar rofi sddm swaync wl-clipboard wlogout swww hypridle hyprlock hyprcursor"
  ["Terminal/Shell"]="zsh gnome-keyring ghostty kitty"
  ["System Services"]="power-profiles-daemon os-prober openrgb eza"
)

# Ask user which package groups to install
echo -e "\n📦 Select package groups to install:"
group_names=()
i=1
for group in "${!package_groups[@]}"; do
  echo "$i) $group"
  group_names+=("$group")
  ((i++))
done
echo "0) Install ALL packages"

read -p "Enter numbers (e.g. 1 3 5 or 0 for ALL): " -a group_choices

selected_packages=()
if [[ " ${group_choices[*]} " =~ " 0 " ]]; then
  for group in "${package_groups[@]}"; do
    selected_packages+=($group)
  done
else
  for choice in "${group_choices[@]}"; do
    if [[ $choice -ge 1 && $choice -le ${#group_names[@]} ]]; then
      group_name="${group_names[$((choice - 1))]}"
      selected_packages+=(${package_groups["$group_name"]})
    fi
  done
fi

if [[ ${#selected_packages[@]} -eq 0 ]]; then
  print_error "No packages selected. Exiting."
  exit 1
fi

echo -e "\n📋 Selected packages:"
printf '%s\n' "${selected_packages[@]}" | sort

if [[ "$DRY_RUN" == "false" ]]; then
  # Install packages with error handling
  if ! yay -S --needed "${selected_packages[@]}"; then
    print_warning "Some packages failed to install."
    read -p "Continue with dotfiles installation anyway? (y/n): " continue_choice
    if [[ "$continue_choice" != "y" ]]; then
      print_error "Installation aborted by user."
      exit 1
    fi
  fi
  print_success "Package installation completed!"
else
  echo "[DRY RUN] Would install: ${selected_packages[*]}"
fi

print_info "Preparing to stow dotfiles..."

# Backup .config if requested
if [[ "$DRY_RUN" == "false" ]]; then
  read -p "Do you want to backup your current .config directory? (y/n, default: y): " backup_choice
  backup_choice=${backup_choice:-y}
  if [[ "$backup_choice" == "y" ]]; then
    mkdir -p ~/.config_backup
    cp -r ~/.config ~/.config_backup/ 2>/dev/null || true
    print_success "Backup of .config created at ~/.config_backup"
  fi
else
  echo "[DRY RUN] Would ask about backing up .config directory"
fi

# Improved conflict-safe stow function
stow_safe() {
  local modules=("$@")
  local target_dir="$HOME"

  if [[ "$DRY_RUN" == "true" ]]; then
    echo "[DRY RUN] Would stow modules: ${modules[*]}"
    return 0
  fi

  cd ~/dotfiles || {
    print_error "Failed to change to dotfiles directory!"
    exit 1
  }

  for module in "${modules[@]}"; do
    if [[ ! -d "$module" ]]; then
      print_warning "Module '$module' not found in dotfiles directory, skipping..."
      continue
    fi

    print_info "Stowing module: $module"

    # More robust conflict detection
    conflicts=$(stow -n -v "$module" 2>&1 | grep -E "(existing target|would conflict)" | grep -o "$target_dir[^ ]*" || true)

    if [[ -n "$conflicts" ]]; then
      print_warning "Conflicts detected for $module:"
      echo "$conflicts"
      read -p "Backup & remove conflicting files? (y/n, default: y): " answer
      answer=${answer:-y}
      if [[ "$answer" == "y" ]]; then
        # Create backup directory if it doesn't exist
        mkdir -p "$HOME/.config_backup_conflicts"

        while IFS= read -r file; do
          if [[ -e "$file" ]]; then
            backup_path="$HOME/.config_backup_conflicts${file#$HOME}"
            mkdir -p "$(dirname "$backup_path")"
            cp -r "$file" "$backup_path" 2>/dev/null || true
            rm -rf "$file"
          fi
        done <<<"$conflicts"
        print_success "Conflicts backed up to ~/.config_backup_conflicts"
      else
        print_warning "Skipping $module"
        continue
      fi
    fi

    if stow "$module"; then
      print_success "Successfully stowed $module"
    else
      print_error "Failed to stow $module"
    fi
  done
}

# Menu for selecting dotfiles modules to stow
declare -A module_map=(
  [1]="waybar"
  [2]="swaync"
  [3]="wlogout"
  [4]="nvim"
  [5]="rofi"
  [6]="kitty"
  [7]="yazi"
  [8]="spicetify"
  [9]="matugen"
  [10]="fastfetch"
  [11]="ohmyposh"
  [12]="qt"
  [13]="gtk"
  [14]="hypr"
  [15]="git"
  [16]="zshrc"
  [17]="wallpapers"
  [18]="mpv"
  [19]="startpage"
  [0]="ALL"
)

echo -e "\n🗃️ Select dotfiles to stow:"
for i in $(printf '%s\n' "${!module_map[@]}" | sort -n); do
  echo "$i) ${module_map[$i]}"
done

read -p "Enter numbers (e.g. 1 5 6 or 0 for ALL): " -a choices

if [[ " ${choices[*]} " =~ " 0 " ]]; then
  selected_modules=()
  for i in "${!module_map[@]}"; do
    if [[ "$i" != "0" ]]; then
      selected_modules+=("${module_map[$i]}")
    fi
  done
else
  selected_modules=()
  for i in "${choices[@]}"; do
    if [[ -n "${module_map[$i]}" ]]; then
      selected_modules+=("${module_map[$i]}")
    fi
  done
fi

if [[ ${#selected_modules[@]} -eq 0 ]]; then
  print_error "No modules selected for stowing."
  exit 1
fi

echo -e "\n📂 Stowing selected modules: ${selected_modules[*]}"
stow_safe "${selected_modules[@]}"

print_info "Enabling system services..."

enable_service() {
  local service="$1"
  local user_service="${2:-false}"

  if [[ "$DRY_RUN" == "true" ]]; then
    echo "[DRY RUN] Would enable service: $service"
    return 0
  fi

  if [[ "$user_service" == "true" ]]; then
    if systemctl --user list-unit-files | grep -q "$service"; then
      systemctl --user enable "$service"
      systemctl --user start "$service" 2>/dev/null || true
      print_success "$service enabled and started for user"
    else
      print_warning "$service not found (user service)"
    fi
  else
    if systemctl list-unit-files | grep -q "$service"; then
      sudo systemctl enable "$service"
      sudo systemctl start "$service" 2>/dev/null || true
      print_success "$service enabled and started"
    else
      print_warning "$service not found (system service)"
    fi
  fi
}

# Enable system services
enable_service "sddm.service"
enable_service "NetworkManager.service"
enable_service "bluetooth.service"
enable_service "power-profiles-daemon.service"

# Enable user services
enable_service "pipewire.service" "true"
enable_service "pipewire-pulse.service" "true"

if [[ "$DRY_RUN" == "true" ]]; then
  print_info "Dry run completed! No actual changes were made."
  echo "To run the script for real, execute: $0"
else
  print_success "Dotfiles installed successfully!"
  echo ""
  echo "🔄 Reboot to ensure all services are running properly"
fi
