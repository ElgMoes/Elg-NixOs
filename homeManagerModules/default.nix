# homeManagerModules/default.nix
{
  imports = [
    ./hyprland.nix
    ./scripts.nix
    ./rofi.nix
    ./waybar.nix
  ];

  home.stateVersion = "25.05";
}