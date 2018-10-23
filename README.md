# Run Spring Boot Apps on Kubernetes
Deploy a spring boot app to kubernetes in just some minutes.

## Build the application jar

```
./gradlew build
```

## Deploy to local kubernetes cluster

### Install and start minikube

Install local kubernetes cluster using [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/).

Then start minikube using this command:
```
$ minikube start
```

### Deploy the image

To deploy a local image you need to set the environment to point
to the kubernetes cluster instead of local docker environment.

```
eval $(minikube docker-env)
```
Then create the docker image from the application jar:
```
docker build -t minikube/hello-kube:1.0 .
```
After creating the docker image we are able to deploy this to local kubernates cluster:
```
kubectl run hello-kube --image=minikube/hello-kube:1.0 
--port=8080 --image-pull-policy=Never
```
Now expose the pod contaienr to the outside world using this command:
```
kubectl expose deployment hello-kube --type=NodePort
```
Finally retrieve the target url where our new service
can be reached:
```
minikube service hello-kube --url
```
This gives you an output with something like this:
_http://192.168.99.100:30296_

The deployment and service exposure can also be done using the yaml config files in sub directory _k8s_:

```
kubectl create -f deployment-local.yml
kubectl create -f service-local.yml
minikube service hello-kube --url
```
You can watch the logs for the application using this command:
```
kubectl logs deployment/hello-kube -f
```
Finally you may scale the instances of the app to 4:
```
kubectl scale --replicas=4 deployment/hello-kube
```
