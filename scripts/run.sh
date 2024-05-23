#!/bin/bash

# Docker config

xhost +local:root
export DISPLAY

docker stop warehouse_rb1_sim_cont && docker rm warehouse_rb1_sim_cont

docker compose up