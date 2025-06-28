1. Networking

Setup custom vpc
Create 2 public subnets (ALB, NAT) and 2 private subnets (EKS, RDS)
Create IG to connect public subnet to the internet
Create NAT Gateway to allow private subnets to make outbound requests
Route Tables to define subnet traffic routing
Security Groups to restrict access (e.g., EKS to DB, client to ALB etc)

2. EKS Cluster

EKS control plane
Node group (EC2 worker nodes)
IAM roles for control plane, nodes, and service accounts

3. Databases
Amazon RDS (PostgreSQL) for order-service
MongoDB Mongo Atlas

4. Secrets
Created in AWS Secrets Manager or as Kubernetes Secrets
DB usernames, passwords
Connection URIs

5. Amazon S3
init.sql (Postgres schema + seed data)
init.json (MongoDB seed data if needed)
Terraform remote state

6. Kubernetes Workloads (via Terraform k8 provider)
user-service and order-service (Deployment, Service (ClusterIP), Config/Secrets mounts)
Ingress controller (e.g., ALB via AWS Load Balancer Controller) is deployed
Exposes services to internet

7. Services Boot and Initialize
A. Init Jobs (PostgreSQL / MongoDB):
K8s Job (runs once) connects to DBs:
Downloads schema from S3 using AWS CLI
Executes with psql or mongosh
Creates tables, collections, and inserts seed data

8. Microservices Start:
user-service connects to MongoDB using env vars/secrets
order-service connects to PostgreSQL using secrets