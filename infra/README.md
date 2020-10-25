# Infrastructure
## How to run

First we need to generate the terraform plan from the template

``` sh
j2 -f json main.tf.j2 regions.json > main.tf
j2 -f json summary.tmpl.j2 regions.json > summary.tmpl
```

Then we need to create the instances in each region and setup the packages on them

``` sh
terraform init
terraform apply
ansible-playbook -i inventory playbook.yml
```

Finally we start the server

``` sh
ansible -i inventory servers -u ubuntu -m shell -a 'cd /home/ubuntu/pingpong && sudo ./start_server.sh'
```

and the clients

``` sh
ansible -i inventory clients -u ubuntu -m shell -a 'cd /home/ubuntu/pingpong && sudo ./start_client.sh 54.66.47.233'
```

replacing the ip with whatever the server ip is (check the =inventory= file).
