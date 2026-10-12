# homeManagerModules/waybar.nix
{ config, lib, pkgs, ... }:
{
  options.elg.waybar.enable = lib.mkEnableOption "Waybar";
  config = lib.mkIf config.my.waybar.enable {
        ome.packages = with pkgs; [ waybar ];
    xdg.configFile."rofi".source = ./config/waybar;
  };
}