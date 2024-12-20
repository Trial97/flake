{
  perSystem = {
    config,
    self',
    pkgs,
    ...
  }: {
    formatter = pkgs.alejandra;
    devShells.default = pkgs.mkShell {
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';

      packages = with pkgs; [
        self'.formatter
        # inputs'.agenix.packages.agenix
        fzf
        just
      ];
    };

    pre-commit.settings.hooks = {
      alejandra.enable = true;
      nil.enable = true;
      prettier = {
        enable = true;
        excludes = ["flake.lock" ".+.frag"];
      };
      actionlint.enable = true;
      statix.enable = true;
      deadnix.enable = true;
      typos.enable = true;
      markdownlint.enable = true;
    };
  };
}
