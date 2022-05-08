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

4. Autoscaling classifies its EC2 instance health status as either healthy or unhealthy.
5. By default, Autoscaling uses EC2 status checks only to determine the health status of an instance
6. When you have one or more ELBs defined with the Autoscaling group, you can configure Autoscaling to use 'both' the EC2 health check and the ELB health check to determine the instance health check
7. Although it's a choice, but it's very important to consider both the health checks..because in case of real faults in one or more EC2 instances, the admin may find it as a false positive, and won't take action unless the damage starts.
8. Health Check interval is 5 minutes by default. Can be changed by the admin.
9. ONce Health check ticks, Autoscaling group would consider an instance unhealthy in any of the following cases-
- EC2 status check report to AS group an instance status other than "Running".
- If ELB health check are configured, either of the report(EC2 or ELB)  saying the instance check as unhealthy.

10. Unlike AZ rebalancing, termination of unhealthy instances happen first, then Autoscaling attempts to launch new instances to replace the ones terminated.
11. Elastic IP and EBS volumes get detached from the terminated instances, you need to manually attach them to the new instances.
