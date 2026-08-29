{
  description = "JesusMtnez's Homelab based on Nix!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-latest,
    }:
    let
      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
            latest = import nixpkgs-latest { inherit system; };
          }
        );

      mkPkgsFor =
        system: pkgset:
        import pkgset {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
    in
    {
      formatter = forAllSystems ({ pkgs, latest }: pkgs.nixfmt-tree);

      packages = forAllSystems (
        { pkgs, latest }:
        {
          site = pkgs.buildNpmPackage {
            pname = "homelab-site";
            version = "0.0.0";
            src = ./.;
            npmDepsHash = "sha256-x0FFrCIEPx1SkfNcuYB8q7NNAKDC/NkgecOq3gf6Xoc=";
            npmFlags = "--omit=dev --ignore-scripts";
            dontNpmBuild = true;
            installPhase = ''
              mkdir -p $out/vendor
              cp node_modules/docsify/dist/docsify.min.js $out/vendor/
              cp -r node_modules/docsify/dist/themes $out/vendor/
              cp docs/index.html $out/index.html
              for f in docs/*.md; do cp "$f" $out/; done
              cp -r docs/img $out/img
            '';
          };
        }
      );

      devShells = forAllSystems (
        { pkgs, latest }:
        {
          default = pkgs.mkShell {
            name = "homelab-shell";
            packages = with pkgs; [
              go-task

              latest.kubectl
              latest.kubernetes-helm
              latest.fluxcd
              sops
              age
            ];

            shellHook = ''
              export KUBECONFIG=kubeconfig
            '';
          };

          site = pkgs.mkShell {
            name = "docs-shell";
            packages = [ pkgs.nodejs ];
            shellHook = ''
              npm install
              export PATH="$PWD/node_modules/.bin:$PATH"
              ln -sfn "$PWD/node_modules/docsify/dist" docs/vendor
            '';
          };
        }
      );

      nixosConfigurations = {
        minerva = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            latest = mkPkgsFor "x86_64-linux" nixpkgs-latest;
          };
          modules = [
            ./hosts/minerva/configuration.nix
          ];
        };
      };
    };
}
