{
  description = "homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/master";
  };

  outputs = { self, nixpkgs, nixpkgs-latest }:
    let
      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
        latest = import nixpkgs-latest { inherit system; };
      });

    in
    {
      packages = forAllSystems ({ pkgs, latest }: {
        site = pkgs.stdenv.mkDerivation {
          name = "homelab-site";
          src = ./.;
          nativeBuildInputs = [ (pkgs.python313.withPackages (ps: [ ps.mkdocs ps.mkdocs-material ])) ];
          buildPhase = "mkdocs build --site-dir $out";
          dontInstal = true;
        };
      });

      devShells = forAllSystems
        ({ pkgs, latest }: {
          default = pkgs.mkShell
            {
              name = "homelab-shell";
              packages = with pkgs; [
                ansible
                sshpass
                go-task

                latest.kubectl
                latest.kubernetes-helm
                sops
                age

                latest.ansible-lint
                yamllint
                nodePackages.prettier
              ];

              shellHook = ''
                export KUBECONFIG=kubeconfig
              '';
            };

          site = pkgs.mkShell
            {
              name = "docs-shell";
              packages = [
                (pkgs.python313.withPackages (ps: [ ps.mkdocs ps.mkdocs-material ]))
              ];
            };
        });

    };
}
