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

To maintain the smooth functioning of the worker nodes and thus the cluster itself.
- API server : **Master's point of contact**. 
  * Takes all the requests from the nodes and fowards it to the concerned component inside the master. 
  * It's a front-end of the control plane. 
  * The Api server is meant to scale automatically as per the load.

- Controller Manager: Monitors and keeps a control on the `Actual state` and the `Desired State `. If K8s is on cloud, the entity is called as `cloud-controller-manager`. Has multiple sub-components:
  * Node Controller
  * Route Controller
  * Service Controller
  * Volume Controller

- etcd: **Database**, that stores all the information about all the pods. 
  * Has metadata and status of the cluster in `key:value` format. 
  * Consistent and highly available. 
  * Fully replicated, secure and fast.
  * It's a separate component, though K8s needs it. API server only can access the etcd. 

- Kube Scheduler: Does the actual ground work as instructed by the API server. Pod creation, has logic on which node the pod has to get created.

- kubectl: **Admin CLI** for the end user that talks to API server.

# Node

- Pod: Pod is the smallest unit of K8s- works like a wrapper for our container. Thus, K8s doesn't have to care about which container engine we are using.
  * No auto healing
  * No auto scaling - Had it been why would we have needed K8s? ;-)
- Kubelet: Controls the pods.
  * It sends the request to API server which in turn sends the information to etcd. This is how the information comes in sync.
  * Listens to K8s master. 
  * Sends success/failure reports to the master.
  * Uses port 10255. 

- Kube proxy: Assigns IP-address to Pods. Container itself doen't get any ip address, but its pod does get one. Pods can't communicate among one another.

- Container Engine: Docker or any other engine which is hosting the image/container.



# Higher Level Kubernetes Objects

- Replication Set: Auto scaling and Auto Healing
- Deployment: Versioning and Rollback
- Service : Create and maintain any service; Statip IP and networking, port sharing etc.
- Volume: Create the non-ephemeral storage 

Kubectl - Single Cloud
Kubeadm - On-Premise
Kubefed - Federated

# Kubernetes Objects

Kubernetes uses objects to represent the state of our cluster.

- What containerized applications are running(and on which node).
- The policies around how those applications behave(restart policities, fault tolerance etc)
- Once you create the object, the k8s system will constantly tries to ensure that the object exist and maintains cluster's desired state.
- Every K8s Object includes two nested fields that govern the object config- the object spec(desired) and the object status(actual).
- All objects are identified by a unique name and a UID

**Basic objects:**

- Pod
- Service
- Volume
- Namespace
- ReplicaSets
- Secrets
- Configmaps
- Deployment
- Jobs
- DaemonSets

**Relationship between these objects**

- Pod manages containers
- Replicaset manages pods
- Services expose pod processes to the outside world
- ConfigMaps and Secrets help us configure pods.


**Kubernetes Object Management** 

- Imperative Method: Use `kubectl` CLI - `create, delete, and replace`
- Declarative Method: Makes use of manifest(.yml/.yaml file). Well suited for production. `kubectl apply` for incremental changes.
