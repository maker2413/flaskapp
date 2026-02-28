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

get-ingress-ip:
	@kubectl get ingress flaskapp -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

kubectl-apply:
	@kubectl apply -f k8s/

kubectl-delete:
	@kubectl delete -f k8s/

helm-install:
	@helm install flaskapp -n flaskapp ./charts/flaskapp --create-namespace

helm-uninstall:
	@helm uninstall flaskapp -n flaskapp
