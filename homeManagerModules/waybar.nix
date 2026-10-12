# homeManagerModules/waybar.nix
{ config, lib, ... }:
{
  options.elg.waybar.enable = lib.mkEnableOption "Waybar";
  config = lib.mkIf config.my.waybar.enable {
    programs.waybar.enable = true;
  };
}