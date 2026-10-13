# hosts/desktop/home.nix
{ ... }:
{
  elg.waybar.enable = true;
  elg.hyprland.enable = true;
  elg.rofi.enable = true;
  elg.scripts.enable = true;
  elg.wallpaper.enable = true;
  elg.cliphist.enable = true;
  elg.swaync.enable = true;

  xdg.configFile."hypr/host".source = ./hypr;
  elg.wallpaper.monitors = [ "DP-1" "HDMI-A-1" ];
}