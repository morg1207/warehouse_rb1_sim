#!/bin/bash


# Docker config
sudo groupadd docker
sudo usermod -aG docker $USER

xhost +local:root
export DISPLAY


# Docker build  and run
docker compose build 
