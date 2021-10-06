let

  sources = import ./nix/sources.nix;
  nixpkgs = sources.nixpkgs;
  pkgs = import nixpkgs {};

  k8s.version = "v1.22.2";

in pkgs.mkShell rec {
  name = "k3s-shell";

  buildInputs = with pkgs; [
    niv

    # Tools
    kubectl # TODO Use k8s.version
    ansible
    ansible-lint

    # Local dev
    (kube3d.override { k3sVersion = k8s.version + "+k3s2"; })
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}
  '';
}
