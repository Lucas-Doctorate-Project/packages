{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/nixos-25.05.tar.gz";
    sha256 = "sha256-4xggC56Rub3WInz5eD7EZWXuLXpNvJiUPahGtMkwtuc=";
  }) {}
}:

with pkgs;

rec {
  batexpe = callPackage ./pkgs/batexpe {};

  batsched-140 = callPackage ./pkgs/batsched/batsched140.nix { inherit loguru redox; intervalset = intervalset-light; };
  batsched = batsched-140;

  batsim = batsim420;
  batsim420 = callPackage ./pkgs/batsim/batsim420.nix { inherit redox; simgrid = simgrid-light; intervalset = intervalset-light; };

  intervalset = callPackage ./pkgs/intervalset {};
  intervalset-light = intervalset.override { withoutBoostPropagation = true; };

  loguru = callPackage ./pkgs/loguru {};

  procset = callPackage ./pkgs/procset {};

  pybatsim-core = pybatsim-core-400;
  pybatsim-functional = pybatsim-functional-400;
  pybatsim-core-400 = callPackage ./pkgs/pybatsim/core400.nix { inherit procset; };
  pybatsim-functional-400 = callPackage ./pkgs/pybatsim/functional400.nix { pybatsim-core = pybatsim-core-400; };
  
  redox = callPackage ./pkgs/redox {};
  
  simgrid = simgrid-400;
  simgrid-light = simgrid-400light;
  simgrid-400 = callPackage ./pkgs/simgrid/simgrid400.nix {};
  simgrid-400light = simgrid-400.override { minimalBindings = true; withoutBin = true; withoutBoostPropagation = true; buildPythonBindings = false; modelCheckingSupport = false; };
}