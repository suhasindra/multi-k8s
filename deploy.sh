docker build -t suhasindra/multi-client:latest -t suhasindra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t suhasindra/multi-server:latest -t suhasindra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t suhasindra/multi-worker:latest -t suhasindra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push suhasindra/multi-client:latest
docker push suhasindra/multi-server:latest
docker push suhasindra/multi-worker:latest

docker push suhasindra/multi-client:$SHA
docker push suhasindra/multi-server:$SHA
docker push suhasindra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=suhasindra/multi-server:$SHA
kubectl set image deployments/client-deployment client=suhasindra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=suhasindra/multi-worker:$SHA