# Week 4 Objective

The main objective of week4 is to add visual layer to our node.js application, restructure Terraform code to use modules and segregate app and infra deployments.  Moreover, the next step in the infra provisioning is to introduce Terragrunt and higher granularity of the deployment process.

## Week 4 tasks

- [Basic Koa with EJS tutorial](https://www.digitalocean.com/community/tutorials/how-to-build-a-hello-world-application-with-koa#step-3-adding-routing-and-view-rendering)
- [Koa with EJS sandbox](https://codesandbox.io/s/koa-ejs-example-jbcx2?file=/views/main.ejs)
- [Terragrunt vs Branches vs Workspaces](<https://blog.gruntwork.io/how-to-manage-multiple-environments-with-terraform-32c7bc5d692>)

1. Add visualization layer to node.js app
2. Integrate the deployments, have running monolithic application
3. Segregate app deployment from infra deployment
4. Modularize infra depoyment
5. Add state encryption and TF state lock with DynamoDB

## Refereces For Week 4 Tasks

- [Tailwind CSS styles](https://github.com/catalinpit/nodejs-tailwind)
- [Tailwind with EJS and Koa](https://stackoverflow.com/questions/72485131/how-to-use-tailwind-with-expressjs-ejs-template)
- [Terraform state locking](https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa)

```bash
npx tailwindcss -i ./src/input.css -o ./public/styles/output.css --watch
```

## Generic References

- [Terraform source](https://github.com/aws-samples/aws-stepfunctions-ecs-fargate-process/tree/main/templates)
- [AWS workshop](https://github.com/awslabs/amazon-ecs-nodejs-microservices/blob/master/2-containerized/infrastructure/ecs.yml)
- [ECS implementation with Terraform step by step](https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c)
- [AWS blog post of accessing ECR via PrivateLink](https://aws.amazon.com/blogs/compute/setting-up-aws-privatelink-for-amazon-ecs-and-amazon-ecr/)
- [Add Terraform Visualization](https://medium.com/vmacwrites/tools-to-visualize-your-terraform-plan-d421c6255f9f)
- [Terraform deployment of WordPress with EKS Fargate](https://levelup.gitconnected.com/serverless-webhosting-with-aws-eks-on-fargate-using-terraform-fcd1d98170c1)
- [Service discovery with ECS Service Connect](https://aws.amazon.com/blogs/aws/new-amazon-ecs-service-connect-enabling-easy-communication-between-microservices/)
- [Cross Region implementation](https://medium.com/@pbijjala/recap-aws-cross-region-support-a7f341a7edd7)
- [12 factor app](https://12factor.net/)

## TO DO

- [Implement auto-scaling](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-configure-auto-scaling.html)
- Add CloudWatch Alerts  when there are HTTP errors
- Introduce terragrunt and separate infra deployment based on the lifecycle
- Add diagrams
- Split the monolithic application into microservices
- Add service discovery
- [Add configurations for different env to App config, initialize the Datavbase with] Lambda(https://aws.amazon.com/blogs/containers/developing-twelve-factor-apps-using-amazon-ecs-and-aws-fargate/)
- Add workflows dependency to ensure app deployment does not start before infra deployments
- Add autoscaling [https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c]
- Post tfsec report to Pull Request
- Default Terraform tags
- Tech debt - IAM policies for VPCE
- Make VPCE prod only
- Add cross region deployment

## Pre-reqs

```bash
terraform providers lock -platform=darwin_arm64 -platform=linux_amd64
```
