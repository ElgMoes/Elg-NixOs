# hosts/laptop/home.nix
{ ... }:
{
  elg.waybar.enable = true;
  elg.hyprland.enable = true;
  elg.rofi.enable = true;
  elg.scripts.enable = true;
  elg.wallpaper.enable = true;
  elg.cliphist.enable = true;
  elg.swanc.enable = true;

  xdg.configFile."hypr/host".source = ./hypr;
}