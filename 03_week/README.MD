### Week 3 tasks

1. Find a free domain name on [Freenom](https://www.freenom.com/en/index.html?lang=en). Note that the domain is yours for 3 months only.
2. Create the DNS hosted zone in AWS before proceeding with the rest of the application. Important: you will have through the steps below each time you reset your AWS academy environment.

```
cd hostedzone
tf init
tf validate
tf plan
tf apply --auto-approve
```

3. Update your nameservers in [Freenom](https://www.freenom.com/en/index.html?lang=en) to point to the nameservers in Route 53. [Follow this video](https://www.youtube.com/watch?v=1UyaaEC1YGg&t=603s) for more details.
4. Proceed with the infrastructure deployment

By the end of week three we will implement the following:

1. Create specific security groups for ALB and ECS Fargate instances
2. VPC endpoint to access ECR over AWS backbone
3. Add SSL certificate for our webapp
4. Add DB deployment and DB initialization
5. Add DB secrets managements

## Refereces For Week 3 Tasks

- [VPC Endpoints to access ECR from ECS tasks with Terraform](https://alexhladun.medium.com/create-a-vpc-endpoint-for-ecr-with-terraform-and-save-nat-gateway-1bc254c1f42)
- [Creating certificate with Amazon ACM and Route53](https://www.tugberkugurlu.com/archive/configure-free-wildcard-ssl-certificate-on-aws-application-load-balancer-through-terraform)
- [Node.js app with MySQL tutorial](edureka.co/blog/node-js-mysql-tutorial/)

## Generic References

- [Terraform source](https://github.com/aws-samples/aws-stepfunctions-ecs-fargate-process/tree/main/templates)
- [AWS workshop](https://github.com/awslabs/amazon-ecs-nodejs-microservices/blob/master/2-containerized/infrastructure/ecs.yml)
- [ECS implementation with Terraform step by step](https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c)
- [AWS blog post of accessing ECR via PrivateLink](https://aws.amazon.com/blogs/compute/setting-up-aws-privatelink-for-amazon-ecs-and-amazon-ecr/)
- [Add Terraform Visualization](https://medium.com/vmacwrites/tools-to-visualize-your-terraform-plan-d421c6255f9f)
- [Terraform deployment of WordPress with EKS Fargate](https://levelup.gitconnected.com/serverless-webhosting-with-aws-eks-on-fargate-using-terraform-fcd1d98170c1)

## TO DO

- Split the monolithic application into microservices
- Task definition and Service definition should be part of app deployment
- Add pages rendering
- Add state encryption
- Add service discovery
- Enhance the application with [Koa tutorial](https://www.tutorialspoint.com/koajs/index.htm)
- Add workflows dependency to ensure app deployment does not start before infra deployments
- Integrate the deployments, have running monolithic application
- Add autoscaling [https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c]
- Use Terragrunt for multi-environment deployment
- Post tfsec report to Pull Request
- Default Terraform tags
- Git tags for releases
- Terraform state lock with DynamoDB
- [Service discovery with ECS Service Connect](https://aws.amazon.com/blogs/aws/new-amazon-ecs-service-connect-enabling-easy-communication-between-microservices/)
- Tech debt - IAM policies for VPCE
- terraform providers lock -platform=darwin_arm64 -platform=linux_amd64
