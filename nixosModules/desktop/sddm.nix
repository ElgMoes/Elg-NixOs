# nixosModules/desktop/sddm.nix
{ config, lib, ... }:
{
  options.my.sddm.enable = lib.mkEnableOption "SDDM login manager";

  config = lib.mkIf config.my.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}