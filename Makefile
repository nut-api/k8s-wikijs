all : start_postgres start_wiki port_forword

## POSTGRES
POSTGRES=postgresql
PGCFG=${POSTGRES}/postgres-configmap.yml
PGSTORAGE=${POSTGRES}/postgres-storage.yaml
PGDEPLOY=${POSTGRES}/postgres-deployment.yaml
PGSERVICE=${POSTGRES}/postgres-service.yaml

start_postgres:
	kubectl apply -f ${PGCFG},${PGSTORAGE},${PGDEPLOY},${PGSERVICE}
#	kubectl get service # extract ip of postgresql here and set it to ENV (POSTGRES_IP)

## WIKI
WIKI=wikijs
WIKICFG=${WIKI}/wikijs-config.yaml
WIKIDEPLOY=${WIKI}/wikijs-deployment.yaml
WIKISECRET=${WIKI}/wikijs-secret.yaml
WIKISERVICE=${WIKI}/wikijs-service.yaml

start_wiki:
	kubectl apply -f ${WIKICFG},${wikisecret},${wikiservice},${WIKIDEPLOY}
#	kubectl get pod

port_forword:
	ssh -i ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) -L \*:30000:0.0.0.0:30000
#	port forward local_machine to nodePort(wikijs-svc)

#clean: delete_wiki delete_postgres
#
#delete_postgres:
#	kubectl delete -f ${PGCFG},${PGSTORAGE},${PGDEPLOYment},${PGSERVICE}
#
#delete_wiki:
#	kubectl delete -f ${WIKICFG},${wikisecret},${wikiservice},${WIKIDEPLOY}