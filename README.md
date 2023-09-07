<div align="center">

<img src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67" align="center" width="144px" height="144px"/>

# Homelab

_my home infrastructure and Kubernetes cluster_

[![Built with nix][NIX-badge]][NIX-link]
[![K3S Version][K3S-badge]][K3S-link]
[![MIT LICENSE][LICENSE-badge]][LICENSE-link]

</div>

  [LICENSE-badge]: https://img.shields.io/badge/license-MIT-green.svg?style=flat-square
  [LICENSE-link]: /LICENSE
  [NIX-badge]: https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5&style=flat-square
  [NIX-link]: https://builtwithnix.org
  [K3S-badge]: https://img.shields.io/badge/k3s-v1.27-blue?style=flat-square&logo=k3s&logoColor=yellow
  [K3S-link]: https://k3s.io

## 💻 Hardware

| Device           | Count | RAM    | Disks               | OS     | Arch  | Purpose      |
| ---------------- | ----- | ------ | ------------------- | ------ | ----- | ------------ |
| Synology DS216j  | 1     | 512 MB | WD Red Nas 4TB (x2) | DSM 7  | armv7 | NFS + NAS    |
| Raspberry Pi 1B  | 1     | 512 MB | SD 32GB             | DietPi | armv6 | DNS (PiHole) |
| Raspberry Pi 3   | 5     | 1 GB   | SD 32GB             | DietPi | armv7 | Kubernetes   |

## 📂 Repository structure

The Git repository contains the following directories:

```sh
📁 archive       # unused / old applications
📁 cluster       # Kubernetes cluster defined as code
├─📁 bootstrap   # not used yet
└─📁 apps        # Apps deployed into the cluster grouped by namespace
📁 provision     # Infrastructure setup defined as code
└─📁 ansible     # Ansible playbooks / roles to setup all the infrastructure
```

## Playbooks

### `entware-install` playbook

Install and configure [Entware][entware] for Synology DSM following [this instructions][entware-dsm].

  [entware]: https://github.com/Entware/Entware/
  [entware-dsm]: https://github.com/Entware/Entware/wiki/Install-on-Synology-NAS

### `k3s-install` playbook

Install or upgrade k3s cluster deployment using k3sup.

### `upgrade` playbook

Upgrade DietPi systems using `apt` and `dietpi` upgrader. Upgrade DSM python installatio in Synology.

## Credits to:

- [k3s](https://k3s.io) by [Rancher](https://rancher.com/)
- [alexellis/k3sup](https://github.com/alexellis/k3sup)
- [OmegaSquad82/ansible-k3sup](https://github.com/OmegaSquad82/ansible-k3sup)
- [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible)
- [k8s-at-home/template-cluster-k3s](https://github.com/k8s-at-home/template-cluster-k3s/)
- [onedr0p/home-ops](https://github.com/onedr0p/home-ops)
- [onedr0p/flux-cluster-template](https://github.com/onedr0p/flux-cluster-template)
