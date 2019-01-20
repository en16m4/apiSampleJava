#/bin/bash

#Running the image from dockerhub repo
kubectl run --image={dockerhub-repo}/images:SampleJavaApp --replicas=3 SampleJavaApp-pod

#Expose the port and type.
kubectl expose deployment/SampleJavaApp-pod --port=8080 --name=SampleJavaApp --type=LoadBalancer

#get list of pods
kubectl get pods

#see that the service is well created
kubectl get services
