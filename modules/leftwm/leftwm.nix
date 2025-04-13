{
  config,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      windowManager.leftwm.enable = true;
    };

    displayManager.ly.enable = true;
  };

  environment.systemPackages = with pkgs; [
    polybarFull
    rofi
    feh
    picom
  ];
}
