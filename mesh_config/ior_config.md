# Enable the automatic route creation
OpenShift routes for Istio Gateways are automatically managed in Red Hat OpenShift Service Mesh. Every time an Istio Gateway is created, updated or deleted inside the service mesh, an OpenShift route is created, updated or deleted. A Red Hat OpenShift Service Mesh control plane component called Istio OpenShift Routing (IOR) synchronizes the gateway route.

By default, IOR is not enabled when a service mesh control plane is created (`ior_enabled: false`). You could activate it when you create the service mesh control plane (change the value to `true`) or later. 

To check what is the value, you could use the following command

```
oc get smcp basic-install -n istio-system -o json | jq '.spec.istio.gateways'
```

![ior value](./images/ior_value.png)

If the value is false, you could change it with the folloing command:

```
oc -n istio-system patch --type='json' smcp basic-install -p '[{"op": "replace", "path": "/spec/istio/gateways/istio-ingressgateway/ior_enabled", "value":true}]'
```
