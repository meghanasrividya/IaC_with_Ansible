# What is Blue Green Deployment?

- A blue/green deployment is a deployment strategy in which you create two separate, but identical environments. One environment (blue) is running the current application version and one environment (green) is running the new application version. Using a blue/green deployment strategy increases application availability and reduces deployment risk by simplifying the rollback process if a deployment fails. Once testing has been completed on the green environment, live application traffic is directed to the green environment and the blue environment is deprecated.
image

![image](https://user-images.githubusercontent.com/97250268/201677748-17958dce-e930-4a1b-a66c-cd84022b676b.png)


# What are the Benefits?

- Rapid releasing. For product owners working within CI/CD frameworks, blue-green deployments are an excellent method to get your software into production.
- Simple rollbacks.
- Built-in disaster recovery.
- Load balancing.

# How Blue Green Deployment works?

- The main prerequisite for a blue/green deployment is having two identical production environments, with a router, load balancer, or service mesh that can switch traffic between them. 

- The blue/green deployment process works as follows:

- Deploy new version—deploy the new (green) version alongside the current (blue) version. Test it to ensure it works as expected, and deploy changes to it if needed.
- Switch over traffic—when the new version is ready, switch overall traffic from blue to green. This should be done seamlessly so end-users aren’t interrupted.
- Monitor—closely monitor how users interact with the new version and watch out for errors and issues.
- Deploy or rollback—if there is a problem, immediately roll back by switching traffic back to the blue version. Otherwise, keep traffic on the green version and continue using it. The green version now becomes the blue (current) version, and a new version can be deployed alongside it as the “new green” version.

# How to implement it in DevOPs
