# homeManagerModules/wallpaper.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.elg.wallpaper;

  small = pkgs.runCommand "small_wallpaper.jpg"
    { nativeBuildInputs = [ pkgs.imagemagick ]; }
    ''
      magick ${cfg.image} -resize 1280x720\> -quality 85 $out
    '';

  blurred = pkgs.runCommand "blurred_wallpaper.jpg"
    { nativeBuildInputs = [ pkgs.imagemagick ]; }
    ''
      magick ${cfg.image} -resize 640x360\> -gaussian-blur 0x8 $out
    '';
in
{
  options.elg.wallpaper = {
    enable = lib.mkEnableOption "Default wallpaper";
    image = lib.mkOption {
      type = lib.types.path;
      default = ./wallpapers/Malenia.jpg;
      description = "Wallpaper used by hyprpaper and rofi";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      wallpaper {
          monitor =
          path = ${cfg.image}
          fit_mode = cover
      }

      ipc = true
      splash = false
    '';

    xdg.configFile."elg/cache/current_wallpaper".text = "${cfg.image}\n";
    xdg.configFile."elg/cache/current_wallpaper.rasi".text = ''
      * { current-image: url(${cfg.image}, height); }
    '';

    xdg.configFile."elg/cache/small_wallpaper.jpg".source = small;
    xdg.configFile."elg/cache/blurred_wallpaper.jpg".source = blurred;
  };
}