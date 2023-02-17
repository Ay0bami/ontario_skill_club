## Week 2 tasks

By the end of week two we will implement the following:
### Done:
1. CICD workflow for the application deployment. The workflow will implement the steps below:
    1. Build and unit test conatainer application container image on each push to dev and pull request to master
    2. In addition to the above action, push the image to Amazon ECR. Tag the image with the commit hash
    3. Render task definition with the new image tag
    4. Deploy task definition
2. Use private subnets to host application and public subnets to host ALB

### Not Done:
3. Create spicific security groups for ALB and ECS Fargate instances
4. VPC endpoint to access ECR over AWS backbone

## References For Week 2 Tasks 

- [Terraform source](https://github.com/aws-samples/aws-stepfunctions-ecs-fargate-process/tree/main/templates)
- [AWS workshop](https://github.com/awslabs/amazon-ecs-nodejs-microservices/blob/master/2-containerized/infrastructure/ecs.yml)
- [ECS implementation with Terraform step by step](https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c)
- [Deployment automation with GitLab](https://gist.github.com/enginaltay/cc8b577b1c62322d42c8991ff1ce6b6d)
- [Continuous deployment with GitHub Actions](https://aws.amazon.com/blogs/opensource/github-actions-aws-fargate/)

 ## TO DO:
  - Add diagrams and 6 pillars sections to the README files
  - Add autoscaling [https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c]
  - Split the monolithic application into microservices
  - Add DB service and DB and secrest management
  - Add SNS notifications when deployment is completed and store the status CW. Create dashboards.
  - Create multi-stage deployment
  - Terraform state lock with DynamoDB
  - Add self-signed certificate to ALB, store in ACM
  - Introduce [Terragrunt](https://blog.gruntwork.io/how-to-manage-multiple-environments-with-terraform-using-terragrunt-2c3e32fc60a8)
  - Add [Atlantis](https://medium.com/@unruly_mood/terragrunt-terraform-with-atlantis-to-automate-your-infrastructure-pull-requests-9832dd24e5bf) to look even more professional!
  - Post tfsec report to Pull Request
  - Default Terraform tags
  - Git tags for releases
  - [Service discovery with ECS Service Connect](https://aws.amazon.com/blogs/aws/new-amazon-ecs-service-connect-enabling-easy-communication-between-microservices/)
  - Enhance the application with [Koa tutorial](https://www.tutorialspoint.com/koajs/index.htm)
  
