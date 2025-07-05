#!/bin/bash

set -e # Exit immediately on error

echo -e "\n📦 Checking for yay..."
if ! command -v yay &>/dev/null; then
  echo "yay not found. Installing yay..."
  sudo pacman -Sy --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si)
else
  echo "yay is already installed."
fi

echo -e "\n📥 Installing dependencies..."
packages=(
  ani-cli-git anki bleachbit bluetui bluez bluez-deprecated-tools bluez-utils
  brave-nightly-bin brightnessctl btop cmake code eza fastfetch fd gimp git
  gnome-calculator gnome-keyring hypridle hyprlock kitty matugen-bin nautilus
  nm-connection-editor noto-fonts noto-fonts-cjk noto-fonts-emoji
  noto-fonts-extra ntfs-3g obsidian oh-my-posh openrgb os-prober overskride
  pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse
  power-profiles-daemon rofi sddm spicetify-cli spotify steam stow swaync
  switcheroo swww tmux typst unzip vesktop waybar wl-clipboard wlogout yazi
  yt-dlp zathura zathura-pdf-poppler zsh neovim cava nerd-fonts nwg-look gvfs
  bottom pulsemixer gst-plugins-bad hyprland
  xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland
)

yay -S --needed "${packages[@]}"

echo -e "\n🗃️ Preparing to stow dotfiles..."

# Backup .config if requested
read -p "Do you want to backup your current .config directory? (y/n, default: y): " backup_choice
backup_choice=${backup_choice:-y}
if [[ "$backup_choice" == "y" ]]; then
  mkdir -p ~/.config_backup
  cp -r ~/.config ~/.config_backup/
  echo "✔️ Backup of .config created at ~/.config_backup"
fi

# Conflict-safe stow function
stow_safe() {
  local modules=("$@")
  local target_dir="$HOME"
  cd ~/dotfiles || {
    echo "❌ dotfiles directory not found!"
    exit 1
  }

  for module in "${modules[@]}"; do
    echo -e "\n🔗 Stowing module: $module"
    conflicts=$(stow -n -v "$module" 2>&1 | grep -o "$target_dir[^ ]*")
    if [[ -n "$conflicts" ]]; then
      echo "⚠️ Conflicts detected for $module:"
      echo "$conflicts"
      read -p "Backup & remove conflicting files? (y/n, default: y): " answer
      answer=${answer:-y}
      if [[ "$answer" == "y" ]]; then
        while IFS= read -r file; do
          backup_path="$HOME/.config_backup_conflicts${file#$HOME}"
          mkdir -p "$(dirname "$backup_path")"
          cp -r "$file" "$backup_path"
          rm -rf "$file"
        done <<<"$conflicts"
        echo "✔️ Conflicts backed up to ~/.config_backup_conflicts"
      else
        echo "⏭️ Skipping $module"
        continue
      fi
    fi
    stow "$module"
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
  [0]="ALL"
)

echo -e "\n🗃️ Select dotfiles to stow:"
for i in "${!module_map[@]}"; do
  echo "$i) ${module_map[$i]}"
done

read -p "Enter numbers (e.g. 1 5 6 or 0 for ALL): " -a choices

if [[ " ${choices[*]} " =~ " 0 " ]]; then
  selected_modules=("${module_map[@]}")
  selected_modules=("${selected_modules[@]/ALL/}")
else
  selected_modules=()
  for i in "${choices[@]}"; do
    selected_modules+=("${module_map[$i]}")
  done
fi

echo -e "\n📂 Stowing selected modules: ${selected_modules[*]}"
stow_safe "${selected_modules[@]}"

echo -e "\n🔧 Enabling system services..."

# Enable SDDM (login manager)
if systemctl list-unit-files | grep -q sddm.service; then
  sudo systemctl enable sddm.service
  echo "✔️ sddm enabled"
fi

# Enable NetworkManager
if systemctl list-unit-files | grep -q NetworkManager.service; then
  sudo systemctl enable NetworkManager.service
  sudo systemctl start NetworkManager.service
  echo "✔️ NetworkManager enabled and started"
fi

# Enable Bluetooth
if systemctl list-unit-files | grep -q bluetooth.service; then
  sudo systemctl enable bluetooth.service
  sudo systemctl start bluetooth.service
  echo "✔️ Bluetooth enabled and started"
fi

# Enable Pipewire (user services)
systemctl --user enable pipewire.service pipewire-pulse.service
systemctl --user start pipewire.service pipewire-pulse.service
echo "✔️ Pipewire enabled and started for user"

# Enable Power Profiles Daemon
if systemctl list-unit-files | grep -q power-profiles-daemon.service; then
  sudo systemctl enable power-profiles-daemon.service
  sudo systemctl start power-profiles-daemon.service
  echo "✔️ Power Profiles Daemon enabled and started"
fi

echo -e "\n🎉 Dotfiles installed successfully!"
