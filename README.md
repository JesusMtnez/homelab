[![MIT LICENSE][LICENSE-badge]][LICENSE-link]
[![Built with nix][NIX-badge]][NIX-link]


  [LICENSE-badge]: https://img.shields.io/badge/license-MIT-green.svg?style=flat-square
  [LICENSE-link]: /LICENSE
  [NIX-badge]: https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5&style=flat-square
  [NIX-link]: https://builtwithnix.org


# HomeLab Cluster

My homelab k3s cluster configuration

- [`provision/ansible`](./provision/ansible/) handles nodes configuration and k3s installation

## Playbooks

### `main` playbook

Install or upgrade k3s cluster deployment:

- Apply pre-requirements.
- Download `k3sup` to deploy k3s.
- Install `k3s` in master node.
- Install and join `k3s` cluster in the rest of the nodes.

### `update` playbook

Update system using `apt` and `dietpi` upgrader.

## Credits to:

- [k3s](https://k3s.io) by [Rancher](https://rancher.com/)
- [alexellis/k3sup](https://github.com/alexellis/k3sup)
- [OmegaSquad82/ansible-k3sup](https://github.com/OmegaSquad82/ansible-k3sup)
- [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible)