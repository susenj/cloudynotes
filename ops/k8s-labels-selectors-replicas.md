# Labels and Selectors

- Labels are the mechanism we use to organize k8s objects(pod, node, deployment etc)
- A label is a key:value pair without any predefined meaning that can be attached to the objects.
- Labels are similar to tags in AWS or Git where you use a name for a quick reference.
- Labels doesn't have be unique for any objects. 
- Multiple labels can be attached to one object.


Let's create some similar looking ymls.
```bash
master >ls *.yml
pod-2.yml  pod-3.yml  pod-4.yml  pod-1.yml
```
Currently only the names are changed, rest of the contents including labels are same.
```yaml
master >cat *.yml
kind: Pod
apiVersion: v1
metadata:
  name: bangalorepod
  labels:
    env: development
    class: pods
spec:
    containers:
       - name: freshos
         image: ubuntu
         command: ["/bin/bash", "-c", "while true; do echo Hello-Neeraj; sleep 5 ; done"]

kind: Pod
apiVersion: v1
metadata:
  name: gurgaonpod
  labels:
    env: development
    class: pods
spec:
    containers:
       - name: freshos
         image: ubuntu
         command: ["/bin/bash", "-c", "while true; do echo Hello-Neeraj; sleep 5 ; done"]

kind: Pod
apiVersion: v1
metadata:
  name: punepod
  labels:
    env: development
    class: pods
spec:
    containers:
       - name: freshos
         image: ubuntu
         command: ["/bin/bash", "-c", "while true; do echo Hello-Neeraj; sleep 5 ; done"]

kind: Pod
apiVersion: v1
metadata:
  name: patnapod
  labels:
    env: development
    class: pods
spec:
    containers:
       - name: freshos
         image: ubuntu
         command: ["/bin/bash", "-c", "while true; do echo Hello-Neeraj; sleep 5 ; done"]

```

Create all the pods now `kubectl apply -f <manifest file>`

Let's check the labels associated with the runnin pods by `kubectl get pods --show-labels`

```bash
master >kubectl get pods
NAME           READY   STATUS              RESTARTS   AGE
bangalorepod   1/1     Running             0          12s
gurgaonpod     1/1     Running             0          7s
patnapod       1/1     Running             0          23m
punepod        0/1     ContainerCreating   0          4s
master >kubectl get pods --show-labels
NAME           READY   STATUS    RESTARTS   AGE   LABELS
bangalorepod   1/1     Running   0          27s   class=pods,env=development
gurgaonpod     1/1     Running   0          22s   class=pods,env=development
patnapod       1/1     Running   0          24m   class=pods,env=development
punepod        1/1     Running   0          19s   class=pods,env=development
master >
```

Adding or changing a label via `kubectl label pods <podname> <key:value>`


```bash
master >kubectl label pods bangalorepod site=south
pod/bangalorepod labeled

master >kubectl label pods gurgaonpod site=north
pod/gurgaonpod labeled

master >kubectl get pods --show-labels
NAME           READY   STATUS    RESTARTS   AGE     LABELS
bangalorepod   1/1     Running   0          2m12s   class=pods,env=development,site=south
gurgaonpod     1/1     Running   0          2m7s    class=pods,env=development,site=north
patnapod       1/1     Running   0          25m     class=pods,env=development
punepod        1/1     Running   0          2m4s    class=pods,env=development

master >kubectl label pods punepod site=west
pod/punepod labeled

master >kubectl label pods punepod env=production
error: 'env' already has a value (development), and --overwrite is false
master >kubectl label pods punepod env=production --overwrite
pod/punepod labeled

master >kubectl get pods --show-labels
NAME           READY   STATUS    RESTARTS   AGE     LABELS
bangalorepod   1/1     Running   0          7m51s   class=pods,env=development,site=south
gurgaonpod     1/1     Running   0          7m46s   class=pods,env=development,site=north
patnapod       1/1     Running   0          31m     class=pods,env=development
punepod        1/1     Running   0          7m43s   class=pods,env=production,site=west
master >
```

=========================================================================================

Once the labels are attached to an object, we would ned filters to narrow down and these are called as **label selectors**.

- Equality based - `=` and `!=`
- Set based - `in` and `notin` 


```bash

master >kubectl get pods -l 'site=west'
NAME      READY   STATUS    RESTARTS   AGE
punepod   1/1     Running   0          18m
master >
master >kubectl get pods -l 'site=west' --show-labels
NAME      READY   STATUS    RESTARTS   AGE   LABELS
punepod   1/1     Running   0          18m   class=pods,env=production,site=west
master >
master >kubectl get pods -l 'site!=west' --show-labels
NAME           READY   STATUS    RESTARTS   AGE   LABELS
bangalorepod   1/1     Running   0          19m   class=pods,env=development,site=south
gurgaonpod     1/1     Running   0          18m   class=pods,env=development,site=north
patnapod       1/1     Running   0          42m   class=pods,env=development
master >
master >kubectl get pods -l 'env in (development, testing)' --show-labels
NAME           READY   STATUS    RESTARTS   AGE   LABELS
bangalorepod   1/1     Running   0          19m   class=pods,env=development,site=south
gurgaonpod     1/1     Running   0          19m   class=pods,env=development,site=north
patnapod       1/1     Running   0          43m   class=pods,env=development
master >
master >kubectl get pods -l 'env notin (development, testing)' --show-labels
NAME      READY   STATUS    RESTARTS   AGE   LABELS
punepod   1/1     Running   0          19m   class=pods,env=production,site=west
master >
master >kubectl get pods -l 'class=pods, site=north'
NAME         READY   STATUS    RESTARTS   AGE
gurgaonpod   1/1     Running   0          20m
master >
master >kubectl get pods -l 'class=pods, site=north' --show-labels
NAME         READY   STATUS    RESTARTS   AGE   LABELS
gurgaonpod   1/1     Running   0          21m   class=pods,env=development,site=north
master >
```


# Node Selector

We can instruct `kubectl` to run the deployment or pod in a specific(type of) node. 
The node has to be tagged with that label first and then we can specify the node-selector label so that the deployment happen on that labeled node only.
If there are more than one nodes having same label, kubectl will pick it in FCFS order depending on the resources available.


We can see the existing label on a node and can set a label(example: `hardware=t2-medium`) also. 
```bash
master >kubectl get nodes node1 --show-labels
NAME    STATUS   ROLES                  AGE    VERSION   LABELS
node1   Ready    control-plane,master   136m   v1.20.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node1,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node-role.kubernetes.io/master=
master >
master >
master >kubectl label nodes node1 'hardware=t3-micro'
node/node1 labeled
master >kubectl label nodes node3 'hardware=t2-medium'
node/node3 labeled
master >
master >kubectl get pods --show-labels
NAME      READY   STATUS    RESTARTS   AGE   LABELS
punepod   1/1     Running   0          93m   class=pods,env=production,site=west
master >kubectl get nodes --show-labels
NAME    STATUS   ROLES                  AGE    VERSION   LABELS
node1   Ready    control-plane,master   173m   v1.20.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,hardware=t3-micro,kubernetes.io/arch=amd64,kubernetes.io/hostname=node1,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node-role.kubernetes.io/master=
node2   Ready    <none>                 143m   v1.20.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node2,kubernetes.io/os=linux
node3   Ready    <none>                 142m   v1.20.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,hardware=t2-medium,kubernetes.io/arch=amd64,kubernetes.io/hostname=node3,kubernetes.io/os=linux
master >
```
Create a new yml file and specify the nodeSelector label:

```bash

master >cat pod-5.yml
kind: Pod
apiVersion: v1
metadata:
  name: goapod
  labels:
    env: development
    region: west
spec:
    containers:
       - name: c05
         image: ubuntu
         command: ["/bin/bash", "-c", "while true; do echo Hello-Neeraj; sleep 5 ; done"]
    nodeSelector:    # This is nodeSelector, the label inside of it will be used by kubectl to assign the first node that has the label and the resources needed to run the pod on.
       hardware: t2-medium
master >
master >kubectl apply -f *5*
pod/goapod created
master >
master >kubectl get pods --show-labels
NAME      READY   STATUS    RESTARTS   AGE    LABELS
goapod    1/1     Running   0          15s    env=development,region=west
punepod   1/1     Running   0          101m   class=pods,env=production,site=west
master >kubectl describe pods goapod
Name:         goapod
Namespace:    default
Priority:     0
Node:         node3/192.168.0.6
Start Time:   Sat, 17 Jul 2021 06:54:57 +0000
Labels:       env=development
              region=west
Annotations:  <none>
Status:       Running
IP:           10.5.2.4
IPs:
  IP:  10.5.2.4
Containers:
  c05:
    Container ID:  docker://c64fd8aeb7c3b9f867589bf987c510740a5fe05f782b400d9adc3c7f7d6db8df
    Image:         ubuntu
    Image ID:      docker-pullable://ubuntu@sha256:b3e2e47d016c08b3396b5ebe06ab0b711c34e7f37b98c9d37abe794b71cea0a2
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/bash
      -c
      while true; do echo Hello-Bhupinder; sleep 5 ; done
    State:          Running
      Started:      Sat, 17 Jul 2021 06:55:05 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-6xmrm (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-6xmrm:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-6xmrm
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  hardware=t2-medium
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  30s   default-scheduler  Successfully assigned default/goapod to node3
  Normal  Pulling    27s   kubelet            Pulling image "ubuntu"
  Normal  Pulled     26s   kubelet            Successfully pulled image "ubuntu" in 1.129405644s
  Normal  Created    22s   kubelet            Created container c05
  Normal  Started    22s   kubelet            Started container c05
master >

```

# Replication Controller

This is another kind of an object that creates replicas as opposed to pod where in case the pod gets crashed or not get created for some reason, kubectl doesn't recreate it.

```yaml
kind: ReplicationController               
apiVersion: v1
metadata:
  name: varanasipod
spec:
  replicas: 2            # Create 2 pods at any time using the template below
  selector:               # Tells the basis of pod selection
    myname: Neeraj        # Match with this label                     
  template:                # Actual stuff inside the pod
    metadata:
      name: myreplica
      labels:             # pod label key:value
        myname: Neeraj    # This name should match the replica selector label, then only the replica will be created.
    spec:
     containers:
       - name: c06
         image: ubuntu
         command: ["/bin/bash", "-c", "while true; do echo Hello-Neeraj; sleep 5 ; done"]
```
Once we apply this yml, we see there are 2 pods created which are replicas of each other.

```bash
master >kubectl apply -f pod-7.yml
replicationcontroller/varanasipod created
master >
master >kubectl get rc
NAME          DESIRED   CURRENT   READY   AGE
varanasipod   2         2         2       4m28s
master >
master >kubectl get pods --show-labels
NAME                READY   STATUS    RESTARTS   AGE    LABELS
goapod              1/1     Running   0          40m    env=development,region=west
punepod             1/1     Running   0          142m   class=pods,env=production,site=west
varanasipod-5q4px   1/1     Running   0          16s    myname=Neeraj
varanasipod-p2hmk   1/1     Running   0          16s    myname=Neeraj
master >
master >kubectl get rc --show-labels
NAME          DESIRED   CURRENT   READY   AGE    LABELS
varanasipod   2         2         2       7m7s   myname=Neeraj
master >kubectl describe rc varanasipod
Name:         varanasipod
Namespace:    default
Selector:     myname=Neeraj
Labels:       myname=Neeraj
Annotations:  <none>
Replicas:     2 current / 2 desired
Pods Status:  2 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  myname=Neeraj
  Containers:
   c06:
    Image:      ubuntu
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/bash
      -c
      while true; do echo Hello-Neeraj; sleep 5 ; done
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age    From                    Message
  ----    ------            ----   ----                    -------
  Normal  SuccessfulCreate  7m16s  replication-controller  Created pod: varanasipod-p2hmk
  Normal  SuccessfulCreate  7m16s  replication-controller  Created pod: varanasipod-5q4px
master >
```
**Delete a pod and see Replication Controller in action**

```bash

master >kubectl delete pod varanasipod-p2hmk
pod "varanasipod-p2hmk" deleted

master >
master >kubectl get rc
NAME          DESIRED   CURRENT   READY   AGE
varanasipod   2         2         2       9m9s
master >kubectl get pods
NAME                READY   STATUS    RESTARTS   AGE
goapod              1/1     Running   0          49m
punepod             1/1     Running   0          151m
varanasipod-54mn7   1/1     Running   0          58s
varanasipod-5q4px   1/1     Running   0          9m16s
master >kubectl describe rc varanasipod
Name:         varanasipod
Namespace:    default
Selector:     myname=Neeraj
Labels:       myname=Neeraj
Annotations:  <none>
Replicas:     2 current / 2 desired
Pods Status:  2 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  myname=Neeraj
  Containers:
   c06:
    Image:      ubuntu
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/bash
      -c
      while true; do echo Hello-Neeraj; sleep 5 ; done
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From                    Message
  ----    ------            ----  ----                    -------
  Normal  SuccessfulCreate  10m   replication-controller  Created pod: varanasipod-p2hmk
  Normal  SuccessfulCreate  10m   replication-controller  Created pod: varanasipod-5q4px
  Normal  SuccessfulCreate  107s  replication-controller  Created pod: varanasipod-54mn7
master >
```

```bash
master >kubectl scale --replicas=6 rc -l 'myname=Neeraj'
replicationcontroller/varanasipod scaled
master >kubectl get rc
NAME          DESIRED   CURRENT   READY   AGE
varanasipod   6         6         2       13m
master >kubectl get pods
NAME                READY   STATUS              RESTARTS   AGE
goapod              1/1     Running             0          53m
punepod             1/1     Running             0          155m
varanasipod-46jwn   0/1     ContainerCreating   0          26s
varanasipod-54mn7   1/1     Running             0          4m57s
varanasipod-5q4px   1/1     Running             0          13m
varanasipod-dl8tw   0/1     ContainerCreating   0          26s
varanasipod-tkbnw   0/1     ContainerCreating   0          26s
varanasipod-wqmj2   0/1     ContainerCreating   0          27s
master >
```

# ReplicaSet

Replicaset is superset of replicationController. It supports both equality-based and set-based selectors. 
Remember, rc used to have only equality-based selectors.

Need to have two mandatory changes in the yml:

```yaml
kind: replicaSet
version: apps/v1
```
Sample yaml file below: 

```Yaml
kind: ReplicaSet                                    
apiVersion: apps/v1                            
metadata:
  name: delhipod
spec:
  replicas: 2  
  selector:                  
    matchExpressions:          # these must match the labels
      - {key: myname, operator: In, values: [Neeraj, Nee, neeraj, nee]}
      - {key: env, operator: NotIn, values: [production]}
  template:      
    metadata:
      name: delhipod
      labels:              
        myname: neeraj
    spec:
     containers:
       - name: c08
         image: ubuntu
         command: ["/bin/bash", "-c", "while true; do echo Hello-Neeraj; sleep 5 ; done"]
```

Let's create the replicaset.

```bash
[node1 ~]$ kubectl apply -f rs.yml
replicaset.apps/delhipod created
[node1 ~]$ kubectl get rs --show-labels
NAME       DESIRED   CURRENT   READY   AGE   LABELS
delhipod   2         2         2       14s   <none>
[node1 ~]$ kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
delhipod-bwnzt   1/1     Running   0          23s
delhipod-kdz7d   1/1     Running   0          23s
[node1 ~]$ kubectl scale --replicas=1
deployment             replicationcontroller
replicaset             statefulset
[node1 ~]$ kubectl scale --replicas=1 replicaset delhipod
replicaset.apps/delhipod scaled
[node1 ~]$ kubectl get pods
NAME             READY   STATUS        RESTARTS   AGE
delhipod-bwnzt   1/1     Running       0          63s
delhipod-kdz7d   1/1     Terminating   0          63s
[node1 ~]$ kubectl delete pod delhipod-bwnzt
pod "delhipod-bwnzt" deleted
[node1 ~]$
[node1 ~]$ kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
delhipod-djzzg   1/1     Running   0          57s
[node1 ~]$ kubectl get rs
NAME       DESIRED   CURRENT   READY   AGE
delhipod   1         1         1       2m33s
[node1 ~]$
[node1 ~]$
```