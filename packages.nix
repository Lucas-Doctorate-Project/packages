{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/25.05.tar.gz";
    sha256 = "sha256:06jzngg5jm1f81sc4xfskvvgjy5bblz51xpl788mnps1wrkykfhp";
  }) {}
}:

with pkgs;

rec {
  batsim = batsim420;
  batsim420 = callPackage ./pkgs/batsim/batsim420.nix { inherit redox; simgrid = simgrid-light; intervalset = intervalset-light; };

  intervalset = callPackage ./pkgs/intervalset { };
  intervalset-light = intervalset.override { withoutBoostPropagation = true; };
  
  redox = callPackage ./pkgs/redox { };
  
  simgrid = simgrid-400;
  simgrid-light = simgrid-400light;
  simgrid-400 = callPackage ./pkgs/simgrid/simgrid400.nix {};
  simgrid-400light = simgrid-400.override { minimalBindings = true; withoutBin = true; withoutBoostPropagation = true; buildPythonBindings = false; modelCheckingSupport = false; };
}