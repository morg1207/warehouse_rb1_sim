<sub>🌐 **English** · [Español](README.es.md)</sub>

# RB1 Robot — Warehouse Simulation (ROS 2 Humble + Gazebo + Docker)

Gazebo simulation of the **RB1 mobile robot** in a warehouse, for ROS 2 Humble. It is the simulation used by
[rb1_autonomy](https://github.com/morg1207/rb1_autonomy) (Nav2 + behavior trees) and can be run natively or in
a **Docker Compose** container.

| Gazebo | RViz |
|---|---|
| <img src="./images/gazebo.png" alt="Gazebo" width="380"/> | <img src="./images/rviz.png" alt="RViz" width="380"/> |

## 1. Native installation

### 1.1 Build
```bash
# Clone the repository
mkdir -p ~/rb1_ws/src
cd ~/rb1_ws/src
git clone https://github.com/morg1207/warehouse_rb1_sim.git

# Install dependencies
sudo apt update
cd ~/rb1_ws
rosdep init
rosdep update --rosdistro $ROS_DISTRO
rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y

# Build
source /opt/ros/humble/setup.bash
colcon build --symlink-install
```

### 1.2 Launch the simulation
```bash
cd ~/rb1_ws
source install/setup.bash
ros2 launch the_construct_office_gazebo warehouse_rb1_rviz.launch.xml
```

## 2. Docker

A Docker Compose setup that runs the RB1 simulation in Gazebo with ROS 2 Humble, with the GUI forwarded to
the host (X11 / WSLg).

### 2.1 Files

| File | Purpose |
|---|---|
| `dockerfile` | Builds the image: ROS 2 Humble, Gazebo 11, ros2_control, RViz and this repository. |
| `docker-compose.yml` | Runs the container with access to the host display. |
| `scripts/docker_install.sh` | Installs Docker. |
| `scripts/build.sh` | Builds the Docker Compose setup. |
| `scripts/run.sh` | Runs the container. |
| `scripts/stop.sh` | Stops and removes the container. |

### 2.2 Steps

**Install Docker**
```sh
source scripts/docker_install.sh
```

**Build the image**
```sh
xhost +local:root
export DISPLAY

mkdir -p ~/dockers && cd ~/dockers
git clone https://github.com/morg1207/warehouse_rb1_sim.git
cd ~/dockers/warehouse_rb1_sim
docker compose build
```

**Run the container**
```sh
cd ~/dockers/warehouse_rb1_sim
docker compose up
```

**Stop the container**
```sh
source scripts/stop.sh
```

**Rebuild the image without cache** (to pull the latest version of this repository)
```sh
docker build -t warehouse_rb1_sim --build-arg CACHEBUST=$(date +%s) .
```

## Acknowledgements

This repository is based on a simulation provided by [The Construct](https://www.theconstruct.ai/). Thanks for
their work and educational resources, which were essential to build it.

<img src="./images/the_construct.png" alt="The Construct" width="200"/>
