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
- In DevOps, the basic idea behind Blue-Green deployment model is to gradually switch the customer traffic between two identical fleets of app servers in production environment. The very important component in Blue-Green deployment is the load balancer or proxy, through which the customer traffic enters into the production environment. Many people use Nginx or HAProxy to route customer traffic to app servers. If you are in AWS, you can use Amazon EC2 ELB to route customer traffic to your app servers.

- Now, let's assume that current customer traffic is served by Blue fleet app servers, while the Green fleet app servers are offline. Here are the steps to effectively perform Blue-Green deployment in our production environment.

- Boot the Green fleet app servers and bring them online.

- Deploy the app source code on to the Green fleet app servers. We can use Chef, Ansible, Salt to execute deployments on the app servers. After the deployment, we need to test all the features of the product.

- Our customers will face downtimes, glitches, errors, and timeouts if we switch the live customer traffic without doing proper warmup. So, we need to warmup the Green fleet app servers by putting an artificial workload that is equivalent to the production workload handled by Blue fleet app servers.

- Gradually switch the customer traffic towards Green fleet app servers by controlling the load balancer or proxy. Our app servers will go down if we switch the entire customer traffic at once. First, we must try switching 5% of the customer traffic from Blue fleet app servers to Green fleet app servers by controlling the load balancer. Then, check the error rate and app performance. If everything is stable, we need to repeat the same by switching the next 20%, 25%, and 50% of the customer traffic.

- If the 100% customer traffic is switched to Green fleet app servers, then we can take the Blue fleet app servers to offline mode.

- In the next deployment, repeat the above steps vice versa.
