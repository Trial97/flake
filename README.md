# Readme

## ToDo

- [ ] Populate the commands needed for first install
- [ ] Test first install
- [ ] Migrate from the old config

## Decisions

- one user( no need for extra home-management programs)
- one window manager(consider posibility of adding more)
- manage part of secrets manually

## Structure

```
|-> home                ~ home manager configuration
|-> system              ~ system configuration
| |-> original          ~ the original system configuration (will be removed later)
| |-> bluetooth.nix     ~ bluetooth config
| |-> boot.nix          ~ boot config
| |-> default.nix       ~ entry point to the system config
| |-> environment.nix   ~ environment variables definition
| |-> fonts.nix         ~ fonts definition
| |-> git.nix           ~ git config
| |-> home.nix          ~ homemanager bootstrap
| |-> networking.nix    ~ firewall
| |-> nix.nix           ~ nix related
| |-> regional.nix      ~ locale settings
|-> .envrc              ~ the direnv config (used to autoinitalize the dev shell)
|-> .gitignore          ~ files for git to ignore
|-> dev.nix             ~ the shell configuration
|-> flake.lock          ~ flake lock file(do not edit manualy:`just u`)
|-> flake.nix           ~ flake entry point and the inputs location
|-> justfile            ~ shortcuts for build commands
|-> LICENSE             ~ project license
|-> README.md           ~ documentaion of the flake
```

## Secrets

|  Secret  | Management | Reasoning                                                   |
| :------: | :--------: | :---------------------------------------------------------- |
|   ssh    |   manual   | Most secret management schema needs one manual key at least |
|   gpg    |   manual   | One more doesn't need to include it inside the flake        |
| password |   manual   | Set it up on os install and forget about it                 |

## First install steps

1. Go through the main instalation but do not restart
2. Mount the new generated partition
3. Copy secrets inside
4. chroot inside the install
5. Move the secrets in the corect place
6. Fix file permisions
7. Install this flake

## Reference

- [1] <https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes>
