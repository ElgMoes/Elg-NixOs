# hosts/vm/home.nix
{ ... }:
{
  elg.waybar.enable = true;
  elg.hyprland.enable = true;
  elg.rofi.enable = true;

  xdg.configFile."hypr/host".source = ./hypr;
}