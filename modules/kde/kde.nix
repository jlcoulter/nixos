{
  config,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      desktopManager.plasma6.enable = true;
    };
    displayManager.ly.enable = true;
  };

  environment.systemPackages = with pkgs; [
  ];
}
