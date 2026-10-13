# homeManagerModules/swaync.nix
{ config, lib, pkgs, ... }:
{
  options.elg.swaync.enable = lib.mkEnableOption "SwayNotificationCenter";

  config = lib.mkIf config.elg.swaync.enable {
    home.packages = [ pkgs.swaynotificationcenter ];
    xdg.configFile."swaync".source = ../config/swaync;
  };
}