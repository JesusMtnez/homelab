{ latest, ... }:

{
  services.k3s = {
    enable = true;
    package = latest.k3s_1_36;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-mode=644"
      "--disable=traefik"
      "--disable=metrics-server"
      "--disable=servicelb"
      "--disable=local-storage"
      "--disable=flannel"
      "--disable-network-policy"
      "--flannel-backend=none"
    ];
  };
}
