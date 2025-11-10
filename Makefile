IMAGE=ghcr.io/arszh/devops-portfolio-app
TAG=latest

.PHONY: run run-linux build push fmt terraform-init terraform-apply ansible

run:
	docker compose up --build -d

# включает node-exporter только на Linux
run-linux:
	docker compose --profile linux up --build -d

build:
	docker build -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)

fmt:
	terraform -chdir=terraform fmt -recursive

terraform-init:
	cd terraform && terraform init

terraform-apply:
	cd terraform && terraform apply -auto-approve

ansible:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
