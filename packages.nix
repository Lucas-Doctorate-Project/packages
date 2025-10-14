{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/25.05.tar.gz";
    sha256 = "sha256:06jzngg5jm1f81sc4xfskvvgjy5bblz51xpl788mnps1wrkykfhp";
  }) {}
}:

with pkgs;

rec {
  simgrid = simgrid-400;
  simgrid-light = simgrid-400light;

  simgrid-400 = callPackage ./pkgs/simgrid/simgrid400.nix {};
  simgrid-400light = simgrid-400.override { minimalBindings = true; withoutBin = true; withoutBoostPropagation = true; buildPythonBindings = false; modelCheckingSupport = false; };
}