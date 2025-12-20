{ pkgs, latest, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.trusted-users = [ "admin" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "ntfs" ];
  };

  networking = {
    hostName = "minerva";
    useDHCP = false;
    interfaces."enp2s0".useDHCP = true;
    wireless.enable = false;
  };

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
    options = "ctrl:nocaps";
  };

  users.users = {
    "admin" = {
      isNormalUser = true;
      description = "administrator";
      extraGroups = [ "wheel" "docker" ];
      packages = with pkgs; [ vim ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGgjymAtk9hHNEGyWBgpWtMf5Jn2JfRcnZJFR4Fix040 jmartinez@albus"
      ];
    };
  };

  environment.systemPackages = with pkgs; [ ];

  networking.firewall.enable = false;

  services = {
    fwupd.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };

    k3s = {
      enable = true;
      package = latest.k3s;
      role = "server";
      extraFlags = [
        "--write-kubeconfig-mode=644"
        "--disable traefik"
        "--disable metrics-server"
        "--disable servicelb"
        "--disable local-storage"
      ];
    };

    openssh.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    extraPackages = [
      pkgs.docker-compose
    ];
  };

  system.stateVersion = "25.05";
}
