# dotfiles
my linux dotfiles and maybe some more

more more

more comits

packages (yay):
vesktop
rofi
spotify
spicetify-cli
zsh
fastfetch
waypaper




github download
powerlevel10k

google the website
oh-my-zsh


# Arch Linux Hyprland Dotfiles

These are my personal configuration files for my Arch Linux system running the Hyprland window manager. This setup is tailored to my preferences and workflow.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Installed Packages](#installed-packages)
- [Screenshots](#screenshots)
- [License](#license)

## Overview

This configuration includes:

- **Window Manager**: Hyprland
- **Terminal Emulator**: Alacritty
- **Shell**: Zsh with Oh My Zsh
- **Editor**: Neovim
- **Compositor**: Integrated with Hyprland
- **Launcher**: Rofi
- **Status Bar**: Waybar
- **Notification Daemon**: Dunst
- **File Manager**: Thunar
- **Browser**: Firefox
- **Wallpaper Manager**: Swaybg
- **Lock Screen**: Swaylock

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/arch-hyprland-dotfiles.git
   ```

2. **Navigate to the directory**:

   ```bash
   cd arch-hyprland-dotfiles
   ```

3. **Run the installation script**:

   ```bash
   ./install.sh
   ```

   *Note: Ensure you review the `install.sh` script before executing it.*

## Installed Packages

To replicate this setup, you'll need to install the following packages:

```bash
# List of explicitly installed packages
# Generated using: pacman -Qqe
alacritty
dunst
firefox
hyprland
neovim
rofi
swaybg
swaylock
thunar
waybar
zsh
# ... add other packages as needed
```

To generate this list on your system, run:

```bash
pacman -Qqe > pkglist.txt
```

If you use an AUR helper like `yay` or `paru`, you can include AUR packages too:

```bash
yay -Qqe > pkglist.txt
```

## Screenshots

*Include screenshots of your desktop setup here.*

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
