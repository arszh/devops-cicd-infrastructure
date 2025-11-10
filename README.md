# Devops-portfolio — Production-Style DevOps (CI/CD, IaC, Observability)
[![CI/CD](https://github.com/arszh/devops-portfolio/actions/workflows/cicd.yml/badge.svg)](https://github.com/arszh/devops-portfolio/actions)

Демонстрационный, но production‑подобный DevOps проект. Покрывает: Docker, GitHub Actions (CI/CD), Terraform (AWS), Ansible, Prometheus/Grafana, cAdvisor, FastAPI.

## Локальный запуск
```bash
make run            # Windows/macOS/WSL2/Любая ОС
# Linux с node-exporter:
make run-linux
```
- http://localhost:8000  — API
- http://localhost:8000/metrics — метрики
- http://localhost:9090  — Prometheus
- http://localhost:3000  — Grafana (admin/admin)
- http://localhost:8080  — cAdvisor

## Деплой в AWS через Terraform
```bash
cd terraform
terraform init
terraform apply -auto-approve -var key_name=YOUR_KEYNAME
```
Запомни `public_ip` → добавь в GitHub Secrets `SERVER_IP`. Добавь также `SSH_PRIVATE_KEY` для пользователя `ubuntu`.

## CI/CD
- Build & Push: `ghcr.io/arszh/devops-portfolio-app:latest`
- Deploy: Ansible по SSH на EC2 → `docker compose up -d`

## Что демонстрирует
- IaC (Terraform)
- Provisioning/Deploy (Ansible)
- CI/CD (GitHub Actions → GHCR → сервер)
- Контейнеризация (Docker)
- Наблюдаемость (Prometheus/Grafana/cAdvisor)
- Документация и читабельная структура

## Структура
```
app/                 # FastAPI demo app
ansible/             # provisioning & deploy
terraform/           # IaC AWS EC2
monitoring/          # Prometheus config
docker/              # Prometheus image (baked config)
.github/workflows/   # CI/CD pipeline
docker-compose.yml   # Desktop-friendly compose (no 'version')
Dockerfile
Makefile
README.md
```
