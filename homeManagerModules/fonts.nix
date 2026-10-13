# homeManagerModules/fonts.nix
{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [ fira font-awesome roboto ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}