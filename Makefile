.PHONY: run

build:
	@docker build \
		-t flask:test \
		.

run:
	@docker run \
		-p 5000:5000 \
		-d \
		--rm \
		--name flask-test \
		flask:test

stop:
	@docker stop flask-test

create-cluster:
	@kind create cluster

delete-cluster:
	@kind delete cluster

run-lb:
	cloud-provider-kind

kubectl-apply:
	@kubectl apply -f k8s/

kubectl-delete:
	@kubectl delete -f k8s/

helm-install:
	@helm install flaskapp -n flaskapp ./charts/flaskapp --create-namespace

helm-uninstall:
	@helm uninstall flaskapp -n flaskapp

helm-argo-repo:
	@helm repo add argo https://argoproj.github.io/argo-helm

helm-argo-install:
	@helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace -f charts/argocd/values.yaml

helm-argo-uninstall:
	@helm uninstall argocd -n argocd && \
	kubectl delete ns argocd

argo-password:
	@ echo "Initial Username: admin" && \
	echo "Initial Password: `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d`"

get-ingress-ip:
	@kubectl get ingress argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

helm-arc-install:
	@helm install arc \
	 --namespace arc-systems \
	 --create-namespace \
	 oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

helm-arc-uninstall:
	@helm uninstall arc -n arc-systems

authenticate-arc:
	@./setup-arc.sh

helm-runner-install:
	@helm install "arc-runner-set" \
		 --namespace "arc-runners" \
		 --create-namespace \
		 --set githubConfigUrl="https://github.com/maker2413/flaskapp" \
		 --set githubConfigSecret="github-pat" \
		 oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set

helm-runner-uninstall:
	@helm uninstall arc-runner-set -n arc-runners
