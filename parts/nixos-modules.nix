{ lib, moduleWithSystem, ... }:

{
  flake.nixosModules =
    lib.genAttrs
      (lib.filesIn ../modules/nixos)
      (module: moduleWithSystem (
        # must use explicit args here to pass them to imported nixos module
        # see `moduleWithSystem` in flake-parts docs for more details
        { inputs, lib, pkgs, unstable }:
        { imports = [ (import (../modules/nixos/. + "/${module}")) ]; }
      ));
}
