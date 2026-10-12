# nixosModules/default.nix  (your "modulebundle")
{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/sddm.nix
  ];
}