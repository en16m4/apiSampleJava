# CI/CD Pipeline.
This is the demo pipeline, demonstrating of "**everything as code**" and "**Build once run anywhere"**.  

    ****Tools**:
    1) Codebase -   Java
    2) Packaging -  Maven
    3) Subversion -  Git
    4) CI  -        Jenkins
    5) Container -  Docker
    6) CD -         Kubernetes**

#**Installation**: 
Jenkins Node: Expecting maven, docker, git, installed. (we can use docker image as slave, which spawned by Jenkins on demand for deployments.)

**Test Server :** 
Install docker, git, java and maven. Kubernetes installed, we can also test the image by deploying to K8 in test environment, so we d not have any surprises on production deployments.

**Production Environment** : Install Docker, Kubernetes. and other required tools. 

**#Procedure**

    Install Jenkins and other required tools
    Specify Jenkinsfile as build script.

**CI CD Pipeline**

    Pull Code - Build-Docker-Image --> push to repo --> Test Image on sparate test environment --> Pull DockerHb -->deploy on Kubernetes cluster --> check for status(200 in this case) -- Notify about the deployment status.(email or slack)


**#Automated Deployment.**

    Create a GitHub "push" web-hook pointing to your Jenkins host , make changes , push to the repo and build run automatically.

**Things Required:** 

    - Configure automated logs exported using Ansible,(logs are pushed post deployments to ELK or Graylog2 or Splunk)
    - Automated monitoring system (post deployment, invoke Prometheus to export metrics to Prometheus and visualise in Grafana).
    - APM based metrics (post deployment/or inject in to docker image, add NewRelic/DataDog APM Config or Others).


**How easy would it be to check what is going on in your environment?
Apart from tools mentioned above, we can run following commands:** 

    :$ kubectl get pods
    :$ kubectl cluster-info
    :$ kubectl get deployment
    :$ kubectl get deployment {my-deployment}
    :$ kubectl describe nodes my-nodes
    :$ kubectl describe pods my-pods
    
    # Get all running pods in the namespace
    :$ kubectl get pods --field-selector=status.phase=Running
    
    #Get ExternalIPs of all nodes
    :$ kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'
    
    # List Events sorted by timestamp
    :$ kubectl get events --sort-by=.metadata.creationTimestamp

    

**Future Improvements:** 
    -> use Hashicorp Packer for creating docker images(not creating un-neccesary docker-image layers thus reducing docker image size.)
    -> use Ansible/Chef or any deployment tools to manage deployments more mature way.
    -> application properties can be fetched from Consul.(http fetch)/dynamic fetch.
    -> Create Deployment status dashboard **(http://dashing.io/)**
    -> we can integrate Terraform IAC(infra as code) for provisioning other components(s3/subnets/security groups)(AWS/GCP)
    -> Use **GitLAb solution for whole CI/CD solution**.
