#!/bin/bash

# Print logo
print_logo() {
  cat <<"EOF"
+============================+
| ____       _               |
|/ ___|  ___| |_ _   _ _ __  |
|\___ \ / _ \ __| | | | '_ \ |
| ___) |  __/ |_| |_| | |_) ||
||____/ \___|\__|\__,_| .__/ |
|                     |_|    |
+============================+

EOF
}

# Clearing terminal and printing logo
clear
print_logo

# exit on error
set -e

# Sourcing utility function
source install\ stuff/utils.sh

# Sourcing packages
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source install\ stuff/packages.conf

echo "Beginning system install"

# Update system
echo "Updating system"
sudo pacman -Syu

# Install yay already installed
if ! command -v yay &>/dev/null; then
  echo "Installing yay..."
  sudo pacman -S --needed git base-devel --noconfirm
  if [[ ! -d "yay" ]]; then
    echo "Cloning yay repository..."
  else
    echo "yay directory already exists, removing it..."
    rm -rf yay
  fi

  git clone https://aur.archlinux.org/yay.git

  cd yay
  echo "building yay..."
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "yay is already installed"
fi

# Install packages
echo "Installing system utilities..."
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing development tools..."
install_packages "${DEV_TOOLS[@]}"

echo "Installing system maintenance tools..."
install_packages "${MAINTENANCE[@]}"

echo "Installing desktop environment..."
install_packages "${DESKTOP[@]}"

echo "Installing desktop environment..."
install_packages "${OFFICE[@]}"

echo "Installing media packages..."
install_packages "${MEDIA[@]}"

echo "Installing fonts..."
install_packages "${FONTS[@]}"
