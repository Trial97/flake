alias b := build
alias c := check
alias dr := dry-run
alias sw := switch
alias t := test
alias u := update

default:
    @just --choose

[private]
rebuild subcmd:
    sudo nixos-rebuild {{ subcmd }} --verbose --flake .

build:
    @just rebuild build

dry-run:
    @just rebuild dry-run

switch:
    @just rebuild switch

test:
    @just rebuild test

update:
    nix flake update --commit-lock-file

check:
    nix flake check \
      --accept-flake-config \
      --no-allow-import-from-derivation
    #   --print-build-logs \
    #   --show-trace \
