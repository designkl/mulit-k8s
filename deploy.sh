docker build -t kevinlien/multi-client:latest -t kevinlien/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kevinlien/multi-server:latest -t kevinlien/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kevinlien/mulit-worker:latest -t kevinlien/mulit-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kevinlien/multi-client:latest
docker push kevinlien/multi-server:latest
docker push kevinlien/multi-worker:latest

docker push kevinlien/multi-client:$SHA
docker push kevinlien/multi-server:$SHA
docker push kevinlien/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kevinlien/multi-server:$SHA
kubectl set image deployments/client-deployment client=kevinlien/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kevinlien/multi-worker:$SHA