{
  description = "homelab";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/release-23.05;
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
          go-task
          kubectl
          nodePackages.prettier
          yamllint
        ];

        shellHook = ''
          export KUBECONFIG=provision/kubeconfig
        '';
      };
    };
  };
}
