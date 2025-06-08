#!/usr/bin/env bash
## /* ---- 🌛 https://github.com/JaKooLit 🌛 ---- */  ##
# Wallpaper selector using swww and rofi, only runs matugen (no wallpaper change)

# Config
wallpaperDir="$HOME/Pictures/wallpapers"
themesDir="$HOME/.config/rofi/themes"
reload="$HOME/.config/hypr/scripts/reload.sh" # Reload swaync, waybar, and rofi

# Get wallpaper list
PICS=($(find -L "${wallpaperDir}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | sort))
randomNumber=$((($(date +%s) + RANDOM) + $$))
randomPicture="${PICS[$((randomNumber % ${#PICS[@]}))]}"
randomChoice="[${#PICS[@]}] Random"

# Rofi menu
menu() {
  printf "$randomChoice\n"
  for pic in "${PICS[@]}"; do
    if [[ ! "$pic" =~ \.gif$ ]]; then
      printf "$(basename \"${pic}\" | cut -d. -f1)\x00icon\x1f${pic}\n"
    else
      printf "$(basename \"${pic}\")\n"
    fi
  done
}

# Only run matugen and optional post-processing
set_wallpaper() {
  ln -sf "$1" "$HOME/.current_wallpaper"
  matugen image "$1"
  [[ -x "$reload" ]] && "$reload"
}

# Main logic
main() {
  pidof rofi >/dev/null && pkill rofi

  choice=$(menu | rofi -show -dmenu \
    -theme "${themesDir}/wallpaper-select.rasi" \
    -kb-row-down j \
    -kb-row-up k \
    -kb-row-right l \
    -kb-row-left h)

  [[ -z "$choice" ]] && exit 0

  if [[ "$choice" == "$randomChoice" ]]; then
    set_wallpaper "${randomPicture}"
    exit 0
  fi

  for file in "${PICS[@]}"; do
    if [[ "$(basename "$file" | cut -d. -f1)" == "$choice" ]]; then
      set_wallpaper "$file"
      exit 0
    fi
  done

  echo "Image not found."
  exit 1
}

main
