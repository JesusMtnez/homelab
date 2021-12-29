let

  sources = import ./nix/sources.nix;
  nixpkgs = sources.nixpkgs;
  niv = sources.niv;
  pkgs = import nixpkgs {};

  k8s.version = "v1.22.5";

in pkgs.mkShell rec {
  name = "k3s-shell";

  buildInputs = with pkgs; [
    (import niv { }).niv

    # Tools
    kubectl
    ansible
    go-task
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}"
  '';
}
