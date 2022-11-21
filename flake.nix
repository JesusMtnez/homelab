{
  description = "homelab";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/release-22.05;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          name = "homelab-shell";
          buildInputs = with pkgs; [
            ansible
            go-task
            kubectl
          ];
        };

        devShells.ci = pkgs.mkShell {
          name = "homelab-shell-ci";
          buildInputs = with pkgs; [
            ansible-lint
            go-task
            nodePackages.prettier
            yamllint
          ];
        };
      }
    );
}
