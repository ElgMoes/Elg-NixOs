# homeManagerModules/kitty.nix
{ config, lib, pkgs, ... }:
{
  options.elg.kitty.enable = lib.mkEnableOption "Kitty terminal";

  config = lib.mkIf config.elg.kitty.enable {
    home.packages = [ pkgs.kitty ];
    xdg.configFile."kitty".source = ../config/kitty;
  };
}