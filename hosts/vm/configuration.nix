# hosts/vm/configuration.nix
{ pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Users
  users.users."ElgMoes" = {
    isNormalUser = true;
    description = "ElgMoes";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "no";
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Set boot settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Locale Settings
  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Nix Setings
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";

  services.openssh.enable = true;

  # Elg's setup
  elg.hyprland.enable = true;
  elg.sddm.enable = true;

  networking.networkmanager.enable = true;
  services.pipewire = { enable = true; alsa.enable = true; pulse.enable = true; };  # pavucontrol
}
