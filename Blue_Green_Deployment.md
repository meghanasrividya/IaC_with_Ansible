# What is Blue Green Deployment?

- A blue/green deployment is a deployment strategy in which you create two separate, but identical environments. One environment (blue) is running the current application version and one environment (green) is running the new application version. Using a blue/green deployment strategy increases application availability and reduces deployment risk by simplifying the rollback process if a deployment fails. Once testing has been completed on the green environment, live application traffic is directed to the green environment and the blue environment is deprecated.
image

![image](https://user-images.githubusercontent.com/97250268/201677748-17958dce-e930-4a1b-a66c-cd84022b676b.png)


# What are the Benefits?

- Rapid releasing. For product owners working within CI/CD frameworks, blue-green deployments are an excellent method to get your software into production.
- Simple rollbacks.
- Built-in disaster recovery.
- Load balancing.
