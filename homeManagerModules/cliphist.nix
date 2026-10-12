# homeManagerModules/cliphist.nix
{ config, lib, pkgs, ... }:
{
  options.elg.cliphist.enable = lib.mkEnableOption "Clipboard history";

  config = lib.mkIf config.elg.cliphist.enable {
    home.packages = with pkgs; [
        cliphist
        wl-clipboard
        wtype
        ];
  };
}