{
  description = "Elg NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      mkHost = name: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/${name}/configuration.nix
          ./nixosModules
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.ElgMoes.imports = [
                ./homeManagerModules
                ./hosts/${name}/home.nix
              ];
            };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        vm = mkHost "vm";
        desktop = mkHost "desktop";
        laptop = mkHost "laptop";
      };
    };
}