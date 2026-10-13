# homeManagerModules/default.nix
{
  imports = [
    ./base
    ./scripts.nix
    ./wallpaper.nix
    ./fonts.nix
  ];

  home.stateVersion = "26.05";
}