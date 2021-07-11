To check the pod details as to on what node it is running or, has been scheduled to run.

```Bash
kubectl get pods -o wide
```

```Bash
master >kubectl get pods -o wide
NAME      READY   STATUS    RESTARTS   AGE   IP         NODE    NOMINATED NODE   READINESS GATES
testpod   1/1     Running   0          15s   10.5.1.2   node2   <none>           <none>
```

MultiContiner Pod YAML:

```YAML
kind: Pod
apiVersion: v1
metadata:
  name: testpod3
spec:
  containers:
    - name: c00
      image: ubuntu
      command: ["/bin/bash", "-c", "while true; do echo Container1; sleep 5 ; done"]
    - name: c01
      image: ubuntu
      command: ["/bin/bash", "-c", "while true; do echo Container2; sleep 5 ; done"]
```

`kubectl exec <podname> -it -c <containername> -- /bin/bash` is the command to go inside the container.

```bash
master >kubectl exec testpod3 -c c01 -it -- /bin/bash
root@testpod3:/#
```


Passing Environment Vars:

```YAML
kind: Pod
apiVersion: v1
metadata:
  name: environments
spec:
  containers:
    - name: c00
      image: ubuntu
      command: ["/bin/bash", "-c", "while true; do echo Container1; sleep 5 ; done"]
      env:                        # List of environment variables to be used inside the pod
        - name: MYNAME
          value: NEERAJ
```

Pod with ports:

```YAML
kind: Pod
apiVersion: v1
metadata:
  name: testpod4
spec:
  containers:
    - name: c00
      image: httpd
      ports:
       - containerPort: 80  
```

