# Containerization:

Gives us a freedom to:
1. Take the image anywhere
2. Within seconds you can make it ready
3. Make better utilization of the system resources



Before K8s:

1. Would you run multiple commands for executing 1000 containers? Maybe writing scripts would help..but is it good for the log run? **Maintenance is costly.**
2. Containers are good, but can we really control it the way we want? What if I made 500 containers, but now need 550. **Need something that would automatically create/teardown containers as needed in real time.**


K8s is an Open-source container management tool which automates
1. Container Deployment
2. Container Scaling
3. Load Balancing

- It schedules, runs, and manages isolated containers which are running on virtual/physical/cloud machines. It is platform independent too, hence.
- Fault Tolerant/Health Monitoring: It senses if pods are not running of errored out, it tries to recreate.
- Rollback: Easy to rollback to previous versions for any number of objects.
Batch execution: Schedule, one time, parallel ..all the ways.


# High level hierarchy of a K8s cluster:

Cluster
   |
Node
   |
Pod
   |
Container
   |
Microservice/Application


# Kubernetes Architecture

Let's look at the K8s architecture:
![K8s architecture taken from its official website](https://d33wubrfki0l68.cloudfront.net/2475489eaf20163ec0f54ddc1d92aa8d4c87c96b/e7c81/images/docs/components-of-kubernetes.svg)


# Master(ControlPlane)

- API server : Master's point of contact. Takes all the requests from the nodes and fowards it to the concerned component inside the master.
- Controller Manager: Monitors and keeps a control on the `Actual state` and the `Desired State `


# Node
- Kube proxy
- Kubelet


