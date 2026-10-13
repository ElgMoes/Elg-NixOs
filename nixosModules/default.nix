# nixosModules/default.nix
{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/sddm.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}