<div align="center">
<img src=img/logo.png align="center" width="144px" height="144px"/>
</div>

## Homelab {: align='center'}
_my home infrastructure and Kubernetes cluster_
{: align='center'}

[![Built with nix][NIX-badge]][NIX-link]
[![K3S Version][K3S-badge]][K3S-link]
[![Woodpecker CI][woodpecker-badge]][woodpecker-link]
![Renovate][renovate-badge]
{: align='center'}


  [NIX-badge]: https://img.shields.io/badge/Built_with_nix-blue.svg?logo=nixos&labelColor=73C3D5
  [NIX-link]: https://builtwithnix.org
  [K3S-badge]: https://img.shields.io/badge/v1.32-blue?&logo=k3s&logoColor=white
  [K3S-link]: https://k3s.io
  [woodpecker-badge]: https://ci.codeberg.org/api/badges/13013/status.svg
  [woodpecker-link]: https://ci.codeberg.org/repos/13013
  [renovate-badge]: https://img.shields.io/badge/passing-blue?logo=renovate&logoColor=white

## 💻 Hardware

| Device           | Count | RAM    | Disks               | OS     | Arch  | Purpose      |
| ---------------- | ----- | ------ | ------------------- | ------ | ----- | ------------ |
| Synology DS216j  | 1     | 512 MB | WD Red Nas 4TB (x2) | DSM 7  | armv7 | NFS + NAS    |
| Raspberry Pi 1B  | 1     | 512 MB | SD 32GB             | DietPi | armv6 | DNS (PiHole) |
| Raspberry Pi 3B  | 5     | 1 GB   | SD 32GB             | DietPi | armv8 | Kubernetes   |

## 📂 Repository structure

The Git repository contains the following directories:

```sh
📁 ansible     # Ansible playbooks / roles to setup all the infrastructure
📁 archive     # unused / old applications
📁 kubernetes  # Kubernetes clusters
└─📁 fluffy    # Cluster 'fluffy' organized by namespaces
```

## Playbooks

### `dietpi-gen` playbook

Bootstrap a DietPi image with `dietpi.txt` file to run an [_unattended base installion_][dietpi-unattended].

  [dietpi-unattended]: https://dietpi.com/docs/usage/#how-to-do-an-automatic-base-installation-at-first-boot-dietpi-automation

### `dietpi-upgrade` playbook

Upgrade DietPi systems using `apt` and `dietpi` upgrader.

> (Disabled) Upgrade DSM python installatio in Synology.

### `k3s-bootstrap` playbook

Configure and setup k3s cluster nodes.

- Secure OpenSSH server
- Enable cgroup support
- Enable containerd (docker)
- Enable nfs support

### `k3s-install` playbook

Install or upgrade k3s cluster deployment using [xanmanning/k3s][xanmanning/k3s].

  [xanmanning/k3s]: https://galaxy.ansible.com/ui/standalone/roles/xanmanning/k3s/

### `k3s-nuke` playbook

Remove k3s cluster deployment using [xanmanning/k3s][xanmanning/k3s].

  [xanmanning/k3s]: https://galaxy.ansible.com/ui/standalone/roles/xanmanning/k3s/

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
