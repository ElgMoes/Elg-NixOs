# homeManagerModules/fonts.nix
{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [ fira font-awesome roboto nerd-fonts.jetbrains-mono];
}