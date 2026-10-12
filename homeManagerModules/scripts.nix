# homeManagerModules/scripts.nix  (general scripts)
{ config, lib, ... }:
{
  options.elg.scripts.enable = lib.mkEnableOption "Personal scripts";

  config = lib.mkIf config.elg.scripts.enable {
    xdg.configFile."elg/scripts".source = ./scripts/elg;
  };
}