all : start_postgres start_wiki port_forword

## POSTGRES
POSTGRES=postgresql
pgcfg=${POSTGRES}/postgres-configmap.yml
pgstorage=${POSTGRES}/postgres-storage.yaml
pgdeploy=${POSTGRES}/postgres-deployment.yaml
pgservice=${POSTGRES}/postgres-service.yaml

start_postgres:
	kubectl apply -f ${pgcfg},${pgstorage},${pgdeploy},${pgservice}
#	kubectl get service # extract ip of postgresql here and set it to ENV (POSTGRES_IP)

## WIKI
WIKI=wikijs
wikicfg=${WIKI}/wikijs-config.yaml
wikideploy=${WIKI}/wikijs-deployment.yaml
wikisecret=${WIKI}/wikijs-secret.yaml
wikiservice=${WIKI}/wikijs-service.yaml

start_wiki:
	kubectl apply -f ${wikicfg},${wikisecret},${wikiservice},${wikideploy}
#	kubectl get pod

port_forword:
	ssh -i ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) -L \*:30000:0.0.0.0:30000
#	port forward local_machine to nodePort(wikijs-svc)

#clean: delete_wiki delete_postgres
#
#delete_postgres:
#	kubectl delete -f ${pgcfg},${pgstorage},${pgdeployment},${pgservice}
#
#delete_wiki:
#	kubectl delete -f ${wikicfg},${wikisecret},${wikiservice},${wikideploy}