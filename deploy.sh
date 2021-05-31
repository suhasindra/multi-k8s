docker build -t suhasindra/multi-client-k8s:latest -t suhasindra/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t suhasindra/multi-server-k8s-pgfix:latest -t suhasindra/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t suhasindra/multi-worker-k8s:latest -t suhasindra/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push suhasindra/multi-client-k8s:latest
docker push suhasindra/multi-server-k8s-pgfix:latest
docker push suhasindra/multi-worker-k8s:latest

docker push suhasindra/multi-client-k8s:$SHA
docker push suhasindra/multi-server-k8s-pgfix:$SHA
docker push suhasindra/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=suhasindra/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=suhasindra/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=suhasindra/multi-worker-k8s:$SHA