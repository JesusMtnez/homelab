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
          site = pkgs.runCommand "homelab-site" { } ''
            mkdir -p $out
            cp ${./.}/docs/index.html $out/index.html
            touch $out/.nojekyll
            for f in ${./.}/docs/*.md; do cp "$f" $out/; done
            cp -r ${./.}/docs/img $out/img
          '';
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
