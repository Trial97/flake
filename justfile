alias b := build
alias dr := dry-run
alias sw := switch
alias t := test
alias u := update
alias vm := build-vm

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

build-vm:
    nix build ".#nixosConfigurations.clockwork.config.system.build.vm"
