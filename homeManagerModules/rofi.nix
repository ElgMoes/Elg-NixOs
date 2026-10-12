# homeManagerModules/rofi.nix
{ config, lib, pkgs, ... }:
{
  options.elg.rofi.enable = lib.mkEnableOption "Rofi";

  config = lib.mkIf config.elg.rofi.enable {
    home.packages = with pkgs; [ rofi rofimoji wl-clipboard wtype ];
    xdg.configFile."rofi".source = ./config/rofi;
  };
}