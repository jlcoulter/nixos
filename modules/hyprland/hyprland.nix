{
  config,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    hyprpaper
    hyprcursor
    dunst
    pipewire
    wireplumber
    hyprpolkitagent
    nwg-look
    pywal
  ];
}
