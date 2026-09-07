# Flux Operator + FluxInstance

GitOps-owned manifests for the Flux Operator bootstrap layer: the operator's
`HelmRelease` (installed from the official OCI chart) and the `FluxInstance`
that drives it. Reconcile by Flux itself via `ks.yaml` once the cluster is up.

## One-time manual bootstrap

On a fresh cluster there is no Flux to apply this yet, so seed it by hand the
first time. NixOS only manages the host (k3s with flannel disabled), so a
one-time `task k8s:bootstrap` performs:

1. `helm upgrade --install cilium` — Cilium as the cluster CNI. Its agent
   DaemonSet runs on host networking, self-registers as the k3s CNI and
   restarts unmanaged pods once networking is up.
2. `helm upgrade --install flux-operator` — the current chart from
   `oci://ghcr.io/controlplaneio-fluxcd/charts`.
3. `kubectl apply -f ./fluxinstance.yaml` — applies the `FluxInstance` that
   makes the operator install the Flux controllers.
4. Waits for the controllers (`kustomize-controller`) to roll out.

The controllers then reconcile `spec.sync` (Codeberg, `refs/heads/k3s`,
`kubernetes/fluffy`), adopt the pre-seeded `cilium` and `flux-operator` helm
releases, and manage all upgrades from git from then on.

## Upgrades

- **Operator**: bump the chart version in `helmrelease.yaml` (Renovate tracks
  it via the `infra/flux-operator/helmrelease.yaml` regex manager).
- **Flux controllers**: bump `spec.distribution.version` in
  `fluxinstance.yaml`; the operator rolls out the new controller images.
- **Cilium**: bump the chart version in
  `apps/kube-system/cilium/helmrelease.yaml`; the helm-controller upgrades it.

## Source of truth

The operator chart lives at
[controlplaneio-fluxcd/charts](https://github.com/controlplaneio-fluxcd/charts).
The `FluxInstance` in `fluxinstance.yaml` is applied as-is by the bootstrap and
managed by Flux afterwards.