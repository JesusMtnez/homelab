{
  description = "homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";

    nixpkgs-latest.url = "github:NixOS/nixpkgs";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    perSystem = { pkgs, ... }: {
      devShells.default = pkgs.mkShell {
        name = "homelab-shell";

        packages = with pkgs; [
          ansible
          sshpass
          go-task

          inputs.nixpkgs-latest.legacyPackages.${system}.kubectl
          inputs.nixpkgs-latest.legacyPackages.${system}.kubernetes-helm
          sops
          age

          ansible-lint
          yamllint
          nodePackages.prettier
        ];

        shellHook = ''
          export KUBECONFIG=kubeconfig
        '';
      };

      packages.site = pkgs.stdenv.mkDerivation {
        name = "homelab-site";
        src = ./.;
        nativeBuildInputs = [ (pkgs.python312.withPackages (ps: [ ps.mkdocs ps.mkdocs-material ])) ];
        buildPhase = "mkdocs build --site-dir $out";
        dontInstal = true;
      };

      devShells.site = pkgs.mkShell {
        name = "docs-shell";

        packages = [
          (pkgs.python312.withPackages (ps: [ ps.mkdocs ps.mkdocs-material ]))
        ];
      };
    };
  };
}
