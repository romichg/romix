[ -f "/etc/romix/romix.conf" ] || exit 0
. /etc/romix/romix.conf

if [ $HIDPI -eq 0 ] || [ $HATE_HIDPI -eq 1 ] 
then
  #Set Dunst Font
  sed -i "s/"DejaVu Sans",*/"DejaVu Sans",16/" $HOME/.config/dunst/dunstrc
  #Set normal dpi in .Xresources
  sed -i "s/Xft.dpi.*/Xft.dpi: 96/" $HOME/.Xresources 
  #Set fonts in rxvt
  sed -i "s/xft:Liberation Mono:pixelsize=.*:antialias=true:hinting=true/xft:Liberation Mono:pixelsize=15:antialias=true:hinting=true/" $HOME/.Xresources 
  sed -i "s/xft:Liberation Mono:bold:pixelsize=.*:antialias=true:hinting=true/xft:Liberation Mono:bold:pixelsize=15:antialias=true:hinting=true/" $HOME/.Xresources 
  #Set up tint2
  sed -i "s/panel_size.*/panel_size = 94% 35/" $HOME/.config/tint2/tint2rc
  sed -i "s/task_maximum_size.*/task_maximum_size = 140 35/" $HOME/.config/tint2/tint2rc
  sed -i "s/task_padding.*/task_padding = 6 2/" $HOME/.config/tint2/tint2rc
  sed -i "s/task_font.*/task_font = sans 9/" $HOME/.config/tint2/tint2rc
  sed -i "s/systray_padding.*/systray_padding = 0 4 5/" $HOME/.config/tint2/tint2rc
  sed -i "s/systray_icon_size.*/systray_icon_size = 16/" $HOME/.config/tint2/tint2rc
  sed -i "s/time1_font.*/time1_font = sans 10/" $HOME/.config/tint2/tint2rc
  sed -i "s/time2_font.*/time2_font = sans 8/" $HOME/.config/tint2/tint2rc
  sed -i "s/clock_padding.*/clock_padding = 1 0/" $HOME/.config/tint2/tint2rc
  sed -i "s/bat1_font.*/bat1_font = sans 8/" $HOME/.config/tint2/tint2rc
  sed -i "s/bat2_font.*/bat2_font = sans 6/" $HOME/.config/tint2/tint2rc
fi

if [ $HIDPI -eq 1 ] && [ $HATE_HIDPI -ne 1 ]
then
  #Set DPI in X, even though it seems useless
  xrandr --dpi $DPI
  #Set Dunst Font
  sed -i "s/"DejaVu Sans",*/"DejaVu Sans",16/" $HOME/.config/dunst/dunstrc
  #Set normal dpi in .Xresources
  sed -i "s/Xft.dpi.*/Xft.dpi: $DPI/" $HOME/.Xresources 
  #Set fonts in rxvt
  sed -i "s/xft:Liberation Mono:pixelsize=.*:antialias=true:hinting=true/xft:Liberation Mono:pixelsize=27:antialias=true:hinting=true/" $HOME/.Xresources 
  sed -i "s/xft:Liberation Mono:bold:pixelsize=.*:antialias=true:hinting=true/xft:Liberation Mono:bold:pixelsize=27:antialias=true:hinting=true/" $HOME/.Xresources 
  #Set up tint2
  sed -i "s/panel_size.*/panel_size = 98% 55/" $HOME/.config/tint2/tint2rc
  sed -i "s/task_maximum_size.*/task_maximum_size = 240 55/" $HOME/.config/tint2/tint2rc
  sed -i "s/task_padding.*/task_padding = 9 3/" $HOME/.config/tint2/tint2rc
  sed -i "s/task_font.*/task_font = sans 15/" $HOME/.config/tint2/tint2rc
  sed -i "s/systray_padding.*/systray_padding = 0 6 7/" $HOME/.config/tint2/tint2rc
  sed -i "s/systray_icon_size.*/systray_icon_size = 32/" $HOME/.config/tint2/tint2rc
  sed -i "s/time1_font.*/time1_font = sans 18/" $HOME/.config/tint2/tint2rc
  sed -i "s/time2_font.*/time2_font = sans 16/" $HOME/.config/tint2/tint2rc
  sed -i "s/clock_padding.*/clock_padding = 4 0/" $HOME/.config/tint2/tint2rc
  sed -i "s/bat1_font.*/bat1_font = sans 14/" $HOME/.config/tint2/tint2rc
  sed -i "s/bat2_font.*/bat2_font = sans 16/" $HOME/.config/tint2/tint2rc
fi

xrdb $HOME/.Xresources

if [ $HATE_HIDPI -eq 1 ] 
then
  xrandr --output eDP1 --scale "$HATE_HIDPI_SCALE"
fi
