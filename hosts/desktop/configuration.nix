# hosts/desktop/configuration.nix
{
  elg.hyprland.enable = true;
  elg.sddm.enable = true;

  networking.networkmanager.enable = true;
  services.pipewire = { enable = true; alsa.enable = true; pulse.enable = true; };  # pavucontrol
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}