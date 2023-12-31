#!/bin/bash
sudo apt update -y
sudo apt-get update -y
sudo apt-get install ec2-instance-connect -y
sudo apt install -y python3-pip
sudo apt install uvicorn -y
sudo apt-get install python3-dev default-libmysqlclient-dev build-essential pkg-config -y
sudo apt-get install git -y
git clone https://github.com/MekhyW/Gym-CRUD.git
cd Gym-CRUD
touch .env
echo "SERVER = ${rds_endpoint}" >> .env
echo "USERNAME = root" >> .env
echo "PASSWORD = megadados" >> .env
echo "DB = academia" >> .env
sudo pip install -U -r requirements.txt
ip_address=$(hostname -I | awk '{print $1}')
sudo uvicorn main:app --host $ip_address --port 80