# k8s-scripts
A collection of scripts for Kubernetes administration.

---
### restart-top-10-mem-hunger-deployment.sh - Restart memory hunger pods

### Usage
```
$ ./restart-top-10-mem-hunger-deployment.sh k8s-worker-7
```
```
kubectl -n verf rollout restart deploy trinity-storefront-deploy # MEM: 1200m
kubectl -n verf rollout restart deploy trinity-api-deploy # MEM: 1200m
kubectl -n torc rollout restart deploy trinity-storefront-deploy # MEM: 1200m
kubectl -n thg-society rollout restart deploy trinity-storefront-deploy # MEM: 1200m
kubectl -n spiffingbrit rollout restart deploy trinity-storefront-deploy # MEM: 1200m
kubectl -n sooxfar rollout restart deploy trinity-storefront-deploy # MEM: 1200m
kubectl -n songhouse rollout restart deploy trinity-storefront-deploy # MEM: 1200m
kubectl -n songhouse rollout restart deploy trinity-api-deploy # MEM: 1200m
kubectl -n solorenekton rollout restart deploy trinity-storefront-deploy # MEM: 1200m
kubectl -n settled rollout restart deploy trinity-api-deploy # MEM: 1200m
```

To execute, run the command with source.
```
$ ./restart-top-10-mem-hunger-deployment.sh k8s-worker-7 | source
```

---
### top-usage-by-ns.sh - List top memory/cpu consuming namespace

### Usage
```
$ ./top-usage-by-ns.sh memory
```
```
--- Top Memory Usage By Namespace ---
NAMESPACE                 MEMORY(bytes)
kube-system               10815Mi
logging                   5713Mi
core                      5702Mi
ingress-nginx             3890Mi
demo                      3574Mi
```

```
$ ./top-usage-by-ns.sh cpu
```
```
--- Top CPU Usage By Namespace ---
NAMESPACE                 CPU(cores)
kube-system               3865m
logging                   752m
monitoring                700m
ingress-nginx             341m
konga                     276m
```
