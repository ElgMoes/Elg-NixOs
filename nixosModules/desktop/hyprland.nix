# nixosModules/desktop/hyprland.nix
{ config, lib, ... }:
{
  options.elg.hyprland.enable = lib.mkEnableOption "Hyprland session";

  config = lib.mkIf config.elg.hyprland.enable {
    programs.hyprland.enable = true;
    programs.hyprlock.enable = true;
  };
}