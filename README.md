# kube-wp
creating a working wordpress blog in k8

## Required ##
- Running kubernetes cluster on AWS (SG region)
- Kubectl installed on local machine which has access to the kubecontrolplan
- aws-iam-authenticator on local machine, it works by providing temp token in order user can interact to the kube-apiserver on the running kube cluster (controlplane)
aws-iam-authenticator will generate temp token based on my AWS Credential stored on ~/.aws/credential
```
[default]
aws_access_key_id = XXXXXXXXXXX
aws_secret_access_key = YYYYYYYYYYYYYYYYYY
```
- helm installed

## Spin up new WP machine ##
read ./spinup.sh

in high level this script will does the following tasks:
- create 1 separated namespace, wordpress
- create 2 PODS:
-- wp application, exposed to other with "LoadBalancer" type of Kube SVC
-- wp database (mariadb), exposed to other with "clusterIP" type of Kube SVC, so we can also access it from the globe
- create 1 Deployment for wordpress application, ensuring we can scale up and down as needed

execute this command
```
sh spinup.sh
```
output:
```
➜  rido-test-kube sh spinup-wp.sh
“spinning up wordpress”
E1222 15:35:54.381384   13176 portforward.go:303] error copying from remote stream to local connection: readfrom tcp4 127.0.0.1:52475->127.0.0.1:52478: write tcp4 127.0.0.1:52475->127.0.0.1:52478: write: broken pipe
wait a sec till ALB is created

Wordpress is ready, visit the page using this link

http://a98789f7c05c411e9abec06118808f8d-1959765982.ap-southeast-1.elb.amazonaws.com
http://a98789f7c05c411e9abec06118808f8d-1959765982.ap-southeast-1.elb.amazonaws.com/admin
```


## Scaling up and down ##
execute this command
```
sh scale.sh
```
output:

```
Currently we have 2 POD(s) wordpress

want to modify the count of wordpress pods? :
[y/n]y


enter the new replica number: 1
deployment.extensions/wordpress-wordpress scaled
```

## Clean up ##
execute this command
```
sh cleanup.sh
```

