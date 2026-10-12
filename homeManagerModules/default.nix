# homeManagerModules/default.nix
{
  imports = [
    ./cliphist.nix
    ./hyprland.nix
    ./scripts.nix
    ./rofi.nix
    ./wallpaper.nix
    ./waybar.nix
    ./swaync.nix
    ./fonts.nix
  ];

  home.stateVersion = "25.05";
}