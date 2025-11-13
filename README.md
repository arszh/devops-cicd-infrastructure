# DevOps-CICD-Infrastructure — Production-Style DevOps (CI/CD, IaC, Observability)
[![CI/CD](https://github.com/arszh/devops-production-demo/actions/workflows/cicd.yml/badge.svg)](https://github.com/arszh/devops-production-demo/actions)

A demonstration but production-like DevOps project. It includes Docker-based services, CI/CD with GitHub Actions, AWS infrastructure provisioning with Terraform, automated deployment via Ansible, and observability with Prometheus/Grafana/cAdvisor. The stack is minimal yet reflects real production workflows.

## 🚀 Local Run
```bash
make run            # Windows/macOS/WSL2/Any OS
# Linux with node-exporter:
make run-linux
```

Available services:
- http://localhost:8000 — API  
- http://localhost:8000/metrics — Metrics endpoint  
- http://localhost:9090 — Prometheus  
- http://localhost:3000 — Grafana (admin/admin)  
- http://localhost:8080 — cAdvisor  

## ☁️ Deploy to AWS Using Terraform
```bash
cd terraform
terraform init
terraform apply -auto-approve -var key_name=YOUR_KEYNAME
```

After apply, copy the `public_ip` → save it in GitHub Secrets as `SERVER_IP`.  
Also add `SSH_PRIVATE_KEY` for the `ubuntu` user.

## 🔁 CI/CD Pipeline
- Build & Push image → `ghcr.io/arszh/devops-production-demo-app:latest`
- Deploy to EC2 via Ansible over SSH
- On the server: `docker compose up -d`

## 🧰 What This Project Demonstrates
- Infrastructure as Code (Terraform → AWS EC2)
- Provisioning & deployment using Ansible
- CI/CD using GitHub Actions + GHCR
- Docker containerization
- Observability: Prometheus, Grafana, cAdvisor
- Clean and readable project layout

## 📁 Project Structure
```
app/                 # FastAPI demo app
ansible/             # provisioning & deployment
terraform/           # IaC AWS EC2 resources
monitoring/          # Prometheus config
docker/              # Prometheus image (baked config)
.github/workflows/   # CI/CD pipeline
docker-compose.yml   # Desktop-friendly compose
Dockerfile
Makefile
README.md
```
