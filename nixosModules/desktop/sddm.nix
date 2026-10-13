# nixosModules/desktop/sddm.nix
{ config, lib, ... }:
{
  options.elg.sddm.enable = lib.mkEnableOption "SDDM login manager";

  config = lib.mkIf config.elg.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}