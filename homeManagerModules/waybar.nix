# homeManagerModules/waybar.nix
{ config, lib, pkgs, ... }:
{
  options.elg.waybar.enable = lib.mkEnableOption "Waybar";

  config = lib.mkIf config.elg.waybar.enable {
    home.packages = with pkgs; [
      waybar
      # add whatever the modules call, see below (playerctl, pavucontrol, brightnessctl, ...)
    ];
    xdg.configFile."waybar".source = ./config/waybar;
  };
}