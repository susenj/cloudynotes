1. Launch Configuration - Instance Type, AMI, keypair, Security Group
2. Autoscaling Group - Group Name, size, VPC, subnet, Health Check period
3. Scaling Policy - Metric Type(Based on which key metric, scaling has to be done), Target Value

AWS can do **predictive scaling** too based on historical trends.

**AutoScaling group**

![image](https://user-images.githubusercontent.com/291550/167292864-66aced0c-a77c-4a89-a5b7-b46c005b75f7.png)

1. An ASG is applied on a set of AZs
2. ASGs do auto-balancing by maintaining equal distribution of EC2 at any point of time.
3. We can attach a running EC2 instance to an ASG by using AWS console or the CLI, if below conditions are met:
- Instances must be in the running state
- AMI used to launch the EC2 still exist
- instance is not part of another ASG
- Instance is in the same AZz which ASG primarily belong to
- If max capacity of the ASG exceeds at some point of time, the instance attach request will not succeed. 
- But in the case of balancing, AWS has a soft elasticity of 10% or 1(whichever is maximum).
