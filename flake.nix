{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nvf,... }@inputs:

  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in 
  {


    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
