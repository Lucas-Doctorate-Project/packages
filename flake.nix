{
  description = "My personal Nix packages repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      inherit (flake-utils.lib) eachSystem filterPackages;
    in
      eachSystem systems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in {
          packages = (filterPackages system (import ./packages.nix { inherit pkgs; }));
        }
      );
}