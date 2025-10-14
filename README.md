# Packages

Personal Nix packages repository for SimGrid and Batsim ecosystem tools.

## Available Packages

- **batexpe** - Go tools for Batsim experiments (robin, robintest)
- **batsched** - C++ scheduling algorithms for Batsim
- **batsim** - Batch simulator
- **intervalset** - Interval set library
- **loguru** - C++ logging library
- **procset** - Process set library
- **pybatsim-core** - Python Batsim core library
- **pybatsim-functional** - Python Batsim functional library
- **redox** - C++ Redis client
- **simgrid** - Distributed systems simulator

## Using as a Flake Input

Add this repository as an input to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    custom-pkgs.url = "github:Lucas-Doctorate-Project/packages";
  };

  outputs = { self, nixpkgs, custom-pkgs }:
    let
      system = "x86_64-linux"; # or "aarch64-darwin"
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          custom-pkgs.packages.${system}.batexpe
          custom-pkgs.packages.${system}.batsched
          custom-pkgs.packages.${system}.batsim
        ];
      };
    };
}
```

## Building Packages

Build any package directly:

```bash
nix build .#batexpe
nix build .#batsched
nix build .#batsim
```

## Development Shell

Enter a shell with all packages available:

```bash
nix develop
```

## Supported Systems

- `x86_64-linux`
- `aarch64-darwin`
