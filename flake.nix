{
  description = "homelab";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/release-23.11;

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
          ansible-lint
          sshpass
          go-task
          kubectl
          nodePackages.prettier
          yamllint
        ];

        shellHook = ''
          export KUBECONFIG=kubeconfig
        '';
      };

      packages.site = pkgs.stdenv.mkDerivation {
        name = "homelab-site";
        src = ./.;
        nativeBuildInputs = [ (pkgs.python311.withPackages (ps: [ ps.mkdocs ps.mkdocs-material ])) ];
        buildPhase = "mkdocs build --site-dir $out";
        dontInstal = true;
      };

      devShells.site = pkgs.mkShell {
        name = "docs-shell";

        packages = [
          (pkgs.python311.withPackages (ps: [ ps.mkdocs ps.mkdocs-material ]))
        ];
      };
    };


  };
}
