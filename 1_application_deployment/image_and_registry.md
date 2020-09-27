# Image And registry

The application used is this git is an simple application, written in Go. 

To simplify the image management, for the example in this repository, the image was loaded into the internal registry of the Openshift instance. It was published on `default` project 
The script provided in this repository is using this internal registry (`image: image-registry.openshift-image-registry.svc:5000/default/myservice:latest`)

To allow other project to pull the image, you should grant  in 'default" project the privilege to pull image to the service account used in the target project. 

For example, if you work on `istio-demo`, you should grant the `default`service account this project to pull image from `default`project. You could do it with the following command:
``` 
oc policy add-role-to-user system:image-puller system:serviceaccount:istio-demo:default --namespace=default
```

A tar file containing the sample application is provided [here](../docker_archive/myservice.tar).

Once you get this archive, you have to tag it for your OpenShift instance then to push it. 