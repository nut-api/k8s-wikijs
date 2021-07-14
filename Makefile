all : start_postgres start_wiki
#all: delete_wiki delete_postgres
## POSTGRES
POSTGRES=postgresql
PGCFG=${POSTGRES}/postgres-configmap.yaml
PGSTORAGE=${POSTGRES}/postgres-storage.yaml
PGDEPLOY=${POSTGRES}/postgres-deployment.yaml
PGSERVICE=${POSTGRES}/postgres-service.yaml

## WIKI
WIKI=wikijs
WIKICFG=${WIKI}/wikijs-config.yaml
WIKIDEPLOY=${WIKI}/wikijs-deployment.yaml
WIKISECRET=${WIKI}/wikijs-secret.yaml
WIKISERVICE=${WIKI}/wikijs-service.yaml


start_postgres:
	kubectl apply -f ${PGCFG},${PGSTORAGE},${PGDEPLOY},${PGSERVICE}
#	kubectl get service # extract ip of postgresql here and set it to ENV (POSTGRES_IP)
start_wiki:
	kubectl apply -f ${WIKICFG},${WIKISECRET},${WIKIDEPLOY},${WIKISERVICE}
#	kubectl get pod



delete_postgres:
	kubectl delete -f ${PGCFG},${PGSTORAGE},${PGDEPLOY},${PGSERVICE}

delete_wiki:
	kubectl delete -f ${WIKICFG},${WIKISECRET},${WIKISERVICE},${WIKIDEPLOY}