# Deploy Jenkins as a service with Helm
* The goal of the exercise is to deploy a Jenkins running instance using the Helm chart located in https://github.com/guipal/jenkins-helm in a local Kubernetes cluster provided with Docker-desktop.
## Create a namespace
* In order to isolate the project from other projects and deployments a new namespace has been created with the following command:
$ kubectl get namespaces