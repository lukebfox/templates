# release.nix
# pins nixpkgs to 19.09 channel for a relatively stable ghc865
let

  bootstrap = import <nixpkgs> {};

  nixpkgs = builtins.fromJSON (builtins.readFile ./nixos-19-09.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

  pkgs = import src {};
  
in
  pkgs.haskellPackages.callCabal2nix "project" ./. {}
