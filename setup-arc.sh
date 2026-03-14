#!/bin/bash

read -p "What is your GitHub PAT: " pat;

echo "apiVersion: v1
kind: Namespace
metadata:
  name: arc-runners" | kubectl apply -f -

kubectl create secret generic github-pat \
   --namespace=arc-runners \
   --from-literal=github_token=$pat;
