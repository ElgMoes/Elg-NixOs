# homeManagerModules/base/ohmyposh.nix
{ config, lib, pkgs, ... }:
{
  options.elg.ohmyposh.enable = lib.mkEnableOption "oh-my-posh prompt";

  config = lib.mkIf config.elg.ohmyposh.enable {
    home.packages = [ pkgs.oh-my-posh ];
    xdg.configFile."ohmyposh".source = ../config/ohmyposh;
  };
}