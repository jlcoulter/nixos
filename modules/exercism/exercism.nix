{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    exercism
  ];
}
