{
  description = "homelab";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/release-23.05;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          name = "homelab-shell";

          buildInputs = with pkgs; [
            ansible
            ansible-lint
            go-task
            kubectl
            nodePackages.prettier
            yamllint
          ];
        };
      }
    );
}
