# RB1 Robot and Warehouse Simulation

A Docker Compose setup for simulating the RB1 robot in Gazebo with ROS2 Humble.

## Files Explained

- `docker-compose.yml`: The Docker Compose file that configures and runs the container.
- `Dockerfile`: The Dockerfile to build the Docker image.
- `build.sh`: Builds the Docker Compose setup.
- `run.sh`: Runs the container.
- `stop.sh`: Stops the container.

## Steps to Run

Run the following commands:


### Install Docker

```sh
source docker_install.sh
```

### Build image

```sh
xhost +local:root
export DISPLAY

# Docker build  and run
cd 
mkdir dockers
cd ~/dockers
git clone git@github.com:morg1207/warehouse_rb1_sim.git
cd ~/dockers/warehouse_rb1_sim 
docker compose build 
```

### Run the container

```sh
cd ~/dockers/warehouse_rb1_sim 
docker compose up
```

### Stop the container

```sh
source scripts/stop.sh

```

### Reconstruir la imagen en el cache 

```sh
docker build -t warehouse_rb1_sim --build-arg CACHEBUST=$(date +%s) .

```

