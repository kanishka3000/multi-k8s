docker build -t kanishka3000/multi-client:latest -t kanishka3000/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kanishka3000/multi-server:latest -t kanishka3000/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kanishka3000/multi-worker:latest -t kanishka3000/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kanishka3000/multi-client:latest
docker push kanishka3000/multi-client:$SHA
docker push kanishka3000/multi-server:latest
docker push kanishka3000/multi-server:$SHA
docker push kanishka3000/multi-worker:latest
docker push kanishka3000/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kanishka3000/multi-server:$SHA
kubectl set image deployments/client-deployment client=kanishka3000/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kanishka3000/multi-worker:$SHA