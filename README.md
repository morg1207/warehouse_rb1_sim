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

```sh
cd src
```

### Install Docker

```sh
source docker_install.sh
```
# Docker config

```sh
newgrp docker
```

### Build image

```sh
source scripts/build.sh
```

### Run the container

```sh
source scripts/run.sh
```

### Stop the container

```sh
source scripts/stop.sh
```

