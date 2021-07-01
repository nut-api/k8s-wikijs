#!/bin/sh
kubectl create -f postgres-configmap.yaml
kubectl create -f postgres-storage.yaml
kubectl create -f postgres-deployment.yaml
kubectl create -f postgres-service.yaml
##Check db
#psql -h localhost -U postgresadmin1 --password -p 31070 postgresdb
kubectl apply -f wikijs-config.yaml
kubectl apply -f wikijs-secret.yaml
kubectl apply -f wikijs-service.yaml
kubectl apply -f wikijs-deployment.yaml
