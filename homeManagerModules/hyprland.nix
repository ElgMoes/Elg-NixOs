# homeManagerModules/hyprland.nix
{ config, lib, pkgs, ... }:
{
  options.elg.hyprland.enable = lib.mkEnableOption "Hyprland user config";

  config = lib.mkIf config.elg.hyprland.enable {
    xdg.configFile."hypr" = {
      source = ./config/hypr;
      recursive = true;
    };
    xdg.configFile."hypr/scripts".source = ./scripts/hypr;

    home.packages = with pkgs; [
      hyprpaper
      hyprpicker
      hyprshot
    ];
  };
}