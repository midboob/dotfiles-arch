# Style-dir
style_dir="$HOME/.config/rofi/styles"

# Style-theme
style_theme='4'

# Run
pkill rofi || true && rofi -show drun -theme ${style_dir}/${style_theme}.rasi
