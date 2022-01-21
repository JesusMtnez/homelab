let

  sources = import ./nix/sources.nix;
  nixpkgs = sources.nixpkgs;
  niv = sources.niv;
  pkgs = import nixpkgs {};

in pkgs.mkShell rec {
  name = "homelab-shell";

  buildInputs = with pkgs; [
    (import niv { }).niv

    # Tools
    ansible
    ansible-lint
    go-task
    kubectl
    nodePackages.prettier
    yamllint
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}"
  '';
}
