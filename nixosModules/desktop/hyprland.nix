# nixosModules/desktop/hyprland.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.my.hyprland;
in
{
  options.my.hyprland.enable = lib.mkEnableOption "Hyprland desktop";

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
    programs.hyprlock.enable = true;

    environment.systemPackages = with pkgs; [
      hyprpicker
      hyprshot
      rofi
      rofimoji
    ];
  };
}