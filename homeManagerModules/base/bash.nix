# homeManagerModules/base/bash.nix
{ config, lib, ... }:
{
  options.elg.bash.enable = lib.mkEnableOption "Bash config";

  config = lib.mkIf config.elg.bash.enable {
    xdg.configFile."bashrc" = {
      source = ../config/bashrc; 
      recursive = true;
    };

    programs.bash = {
      enable = true;
      initExtra = ''
        for f in ~/.config/bashrc/*; do
          if [ ! -d $f ]; then
            c=$(echo $f | sed -e "s=.config/bashrc=.config/bashrc/custom=")
            [[ -f $c ]] && source $c || source $f
          fi
        done
      '';
    };
  };
}