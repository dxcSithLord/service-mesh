# Istio concepts

## Virtual service
A virtual service lets you configure how requests are routed to a service within an Istio service mesh, building on the basic connectivity and discovery provided by Istio and your platform. Each virtual service consists of a set of routing rules that are evaluated in order, letting Istio match each given request to the virtual service to a specific real destination within the mesh. Your mesh can require multiple virtual services or none depending on your use case.

## Destination rule
Destination rules are applied after virtual service routing rules are evaluated, so they apply to the traffic’s “real” destination. They also let you customize Envoy’s traffic policies when calling the entire destination service or a particular service subset, such as your preferred load balancing model, TLS security mode, or circuit breaker settings. 

By default, Istio uses a round-robin load balancing policy, where each service instance in the instance pool gets a request in turn. Istio also supports the following models, which you can specify in destination rules for requests to a particular service or service subset.
* Random: Requests are forwarded at random to instances in the pool.
* Weighted: Requests are forwarded to instances in the pool according to a specific percentage.
* Least requests: Requests are forwarded to instances with the least number of requests.

## Gateway
Gateway let you to manage inbound and outbound traffic for your mesh, letting you specify which traffic you want to enter or leave the mesh. Gateway configurations are applied to standalone Envoy proxies that are running at the edge of the mesh, rather than sidecar Envoy proxies running alongside your service workloads.