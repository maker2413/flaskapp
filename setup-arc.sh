#!/bin/bash

read -p "What is your GitHub PAT: " pat;

kubectl create secret generic github-pat \
   --namespace=arc-runners \
   --from-literal=github_token=$pat;
