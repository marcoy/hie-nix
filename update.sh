#!/bin/sh

set -xe

# needed since that's how stack2nix finds compiler, etc
NIXPKGS_COMMIT=$(nix eval --raw "(builtins.fromJSON (builtins.readFile ./nixpkgs-src.json)).rev")
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/$NIXPKGS_COMMIT.tar.gz

STACK2NIX=$(nix-build -A stack2nix --no-out-link)/bin/stack2nix

COMMIT=2434116d22475affbeb99c14bd4896e6f419d95d
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.6.4.yaml > ghc-8.6.nix
# $STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.4.4.yaml > ghc-8.4.nix
# $STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.2.2.yaml > ghc-8.2.nix
