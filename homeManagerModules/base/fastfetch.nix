# homeManagerModules/base/fastfetch.nix
{ config, lib, pkgs, ... }:
let
  misfortuneCat = pkgs.writeShellApplication {
    name = "misfortune-cat";
    runtimeInputs = [ pkgs.cowsay pkgs.fortune ];
    text = ''
      cowthink -f cute_cat "$(fortune zippy)"
    '';
  };
in
{
  options.elg.fastfetch.enable = lib.mkEnableOption "Fastfetch";

  config = lib.mkIf config.elg.fastfetch.enable {
    home.packages = [ pkgs.fastfetch misfortuneCat ];
    xdg.configFile."fastfetch".source = ../config/fastfetch;
  };
}