#!/usr/bin/env bash
sudo apt-get update 
# get an install docker and curl
sudo apt-get install curl docker.io lvm2
# start docker service
sudo systemctl start docker
sudo systemctl enable docker

# install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /user/bin/docker-compose

echo "User data ran." > /home/ubuntu/did_user_data_run.txt
pushd "/home/ubuntu/deployments/{{ cookiecutter.project_slug }}"
docker-compose up



