<div align="center">
<img src=img/logo.png align="center" width="144px" height="144px"/>
</div>

## 🚀 My Homelab Repository 🚧 {: align='center'}
_... managed with Nix, Flux, Renovate and Forgejo Actions_ 🤖
{: align='center'}

[![Built with nix][nix-badge]][nix-link]
[![k3s version][k3s-badge]][k3s-link]
[![fluxcd version][fluxcd-badge]][fluxcd-link]
[![forgejo][forgejo-actions-badge]][forgejo-actions-link]
[![Renovate][renovate-badge]][renovate-link]
{: align='center'}


  [nix-badge]: https://img.shields.io/badge/25.11-blue.svg?logo=nixos&style=for-the-badge&logoColor=white&color=blue
  [nix-link]: https://builtwithnix.org
  [k3s-badge]: https://img.shields.io/badge/1.34-blue?logo=k3s&style=for-the-badge&logoColor=white&color=blue
  [k3s-link]: https://k3s.io
  [fluxcd-badge]: https://img.shields.io/badge/2.7.5-blue?&logo=flux&style=for-the-badge&logoColor=white&color=blue
  [fluxcd-link]: https://fluxcd.io/
  [forgejo-actions-badge]: https://codeberg.org/JesusMtnez/homelab/badges/workflows/site.yml/badge.svg?&logo=forgejo&style=for-the-badge&logoColor=white&color=blue&label=
  [forgejo-actions-link]: https://codeberg.org/JesusMtnez/homelab/src/branch/main/.forgejo/workflows/site.yml
  [renovate-badge]: https://img.shields.io/badge/passing-blue?logo=renovate&style=for-the-badge&color=blue&logoColor=white
  [renovate-link]: https://codeberg.org/JesusMtnez/automation/src/branch/main/.woodpecker/.renovate.yml
  [homelab]: https://jesusmtnez.es/homelab

## 💻 Hardware

| Device          | Count | RAM    | Disks               | OS     | Arch  | Purpose             |
| --------------- | ----- | ------ | ------------------- | ------ | ----- | ------------------- |
| Synology DS216j | 1     | 512 MB | WD Red Nas 4TB (x2) | DSM 7  | armv7 | NFS + NAS           |
| BMAX B4 Plus    | 1     | 16 GB  | SSD 512GB           | NixOS  | amd64 | Kubernetes (Server) |
| Raspberry Pi 1B | 1     | 512 MB | SD 32GB             | DietPi | armv6 | DNS (PiHole)        |
| Raspberry Pi 3B | 5     | 1 GB   | SD 32GB             | DietPi | armv8 | _undefined_         |

## 📂 Repository structure

The Git repository contains the following directories:

```sh
📁 ansible     # Ansible playbooks / roles to setup all the infrastructure
📁 archive     # unused / old applications
📁 kubernetes  # Kubernetes clusters
└─📁 fluffy    # Cluster 'fluffy' organized by namespaces
📁 nixos       # Hosts configuration based on NixOS
```

## Playbooks

### `dietpi-upgrade` playbook

Upgrade DietPi systems using `apt` and `dietpi` upgrader.

> (Disabled) Upgrade DSM python installatio in Synology.

### `entware-install` playbook

Install and configure [Entware][entware] for Synology DSM following [this instructions][entware-dsm].

  [entware]: https://github.com/Entware/Entware/
  [entware-dsm]: https://github.com/Entware/Entware/wiki/Install-on-Synology-NAS

## Credits

- [k3s](https://k3s.io) by [Rancher](https://rancher.com/)
- [alexellis/k3sup](https://github.com/alexellis/k3sup)
- [OmegaSquad82/ansible-k3sup](https://github.com/OmegaSquad82/ansible-k3sup)
- [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible)
- [k8s-at-home/template-cluster-k3s](https://github.com/k8s-at-home/template-cluster-k3s/)
- [onedr0p/home-ops](https://github.com/onedr0p/home-ops)
- [onedr0p/flux-cluster-template](https://github.com/onedr0p/flux-cluster-template)
