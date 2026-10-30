# NFS persistence recovery

NFS PVCs must keep `helm.sh/resource-policy: keep` so `task k8s:delete` and `task k8s:apply` reuse the same PV.

If a redeploy creates a new PV or binds the wrong NFS path:

1. Identify the expected path:
   `kubectl get pvc -n <namespace> <pvc> -o yaml`
   `kubectl get pv`
2. Delete the app, PVC and stale PVs:
   `task k8s:delete app=<app> ns=<namespace>`
   `kubectl delete pvc -n <namespace> <pvc>`
   `kubectl delete pv <stale-pv> [...]`
3. Reapply and verify:
   `task k8s:apply app=<app> ns=<namespace>`
   `kubectl get pvc,pv -n <namespace>`
   `kubectl get events -n <namespace> --sort-by=.lastTimestamp`

The `nfs.io/storage-path` annotation is appended to `<namespace>/<pvc-name>`. Changing it on an existing PVC does not change the bound PV because the PV's NFS path is immutable; delete/recreate the PVC and PV to apply the new path.

Some apps expect their files directly at the mount root. In that case, set `nfs.io/storage-path` to the directory that should become the PV root, and keep the files directly in that directory rather than adding another subdirectory.

`Retain` keeps NFS data when PV objects are deleted; do not delete the NFS directories.
