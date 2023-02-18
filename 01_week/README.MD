## Week 1 tasks

By the end of week one we want to have a fully functional hosting solution for the containerized monolith `node.js` application.
The hosting solution of week 1 includes the components below:

- VPC with public subnets 
- ALB, Listener, Target Group
- ECS Cluster
- ECS Service, ECS Task Definition
- CloudWatch Log Group
- ECR repo for application container image

### Other tasks of Week 1
1. Create GitHub repo to host infrastructure
2. Add the following
   - gitignore
   - pre-commit
   - worflow to tflint the Terraform code
   - workflow to deploy the code
   - workflow to destroy the code
3. Implement networking
4. Implement ECR, ECS, ALB, CloudWatch Logs
5. Task, Service, Target group in the same repo as core infra components

## Refereces For Week 1 Tasks 
- [Naming convention](https://www.terraform-best-practices.com/naming) for files, folders, resources
    - use underscores
    - use `this` if there is a single resource of this type, e.g. aws_vpc
- `pre-commit` hooks, e.g. `terraform fmt` [best practices](https://terraform-docs.io/how-to/pre-commit-hooks/) and [examples](https://github.com/antonbabenko/pre-commit-terraform)
    ```
    sudo apt install -y python3.7 python3-pip
    python3 -m pip install --upgrade pip
    pip3 install --no-cache-dir pre-commit
    curl -L "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" > tfsec && chmod +x tfsec && sudo mv tfsec /usr/bin/
    curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.zip")" > tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
   pre-commit run -a
    ```

- [Terraform source](https://github.com/aws-samples/aws-stepfunctions-ecs-fargate-process/tree/main/templates)
- [AWS workshop](https://github.com/awslabs/amazon-ecs-nodejs-microservices/blob/master/2-containerized/infrastructure/ecs.yml)
- [ECS implementation with Terraform step by step](https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c)

 ## TO DO:
  - Create app repo with:
      - task definition
      - services 
      - auto-scaling
      - cloudwatch
      - image build and push workflows
      - add VPC endpoint for private ECR access
  - Integrate the deployments, have running monolithic application
  - Add self signed certificate to ALB
  - Add autoscaling [https://awstip.com/how-to-guide-on-deploying-your-nodejs-to-fargate-aws-ecs-ecr-via-terraform-dc224513b41c]
  - Add CloudWatchlog groups
  - See the app running end to end
  - VPC with private subnets
  - Post tfsec report to Pull Request
  - Default Terraform tags
  - Git tags for releases
  - Terraform state lock with DynamoDB
  - Deployment to private subnets
  - Add DB service and DB
  - [Service discovery with ECS Service Connect](https://aws.amazon.com/blogs/aws/new-amazon-ecs-service-connect-enabling-easy-communication-between-microservices/)
  - [Continuous deployment with GitHub Actions](https://aws.amazon.com/blogs/opensource/github-actions-aws-fargate/)
  
