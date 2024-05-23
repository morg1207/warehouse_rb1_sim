# Start from ROS base image
FROM ros:humble-ros-core-jammy

# Make a catkin workspace
WORKDIR /
RUN mkdir -p /sim_ros2_ws/src
WORKDIR /sim_ros2_ws/src

SHELL [ "/bin/bash" , "-c" ]
# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential

# Install Gazebo 11 and other dependencies
RUN apt-get update && apt-get install -y \
  gazebo \
  ros-humble-ros2-controllers-* \
  ros-humble-gazebo-ros-* \
  ros-humble-gazebo-ros2-* \
  ros-galactic-rviz2 \
  && rm -rf /var/lib/apt/lists/*

# Create a volume for ROS packages

RUN git clone -b ros2-galactic https://github.com/rigbetellabs/tortoisebot.git /ros2_ws/src/tortoisebot

RUN echo 

RUN rm -rf  \ 
    /ros2_ws/src/tortoisebot/tortoisebot_firmware \
    /ros2_ws/src/tortoisebot/tortoisebot_control \ 
    /ros2_ws/src/tortoisebot/tortoisebot_navigation \
    /ros2_ws/src/tortoisebot/tortoisebot_bringup \
    /ros2_ws/src/tortoisebot/tortoisebot_slam \
    /ros2_ws/src/tortoisebot/ydlidar-ros2 

COPY ./entrypoints /entrypoints

COPY ./tortoisebot/tortoisebot_bringup /ros2_ws/src/tortoisebot/tortoisebot_bringup
COPY ./tortoisebot/ydlidar-ros2 /ros2_ws/src/tortoisebot/ydlidar-ros2

# Build the Catkin workspace
RUN source /opt/ros/galactic/setup.bash \
    && cd /ros2_ws \
    && colcon build

# Ensure the workspace is sourced
RUN echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc

# Set the entry point to start the ROS launch file
ENTRYPOINT ["/bin/bash", "-c", "source /entrypoints/gazebo_entrypoint.sh"]

#ENTRYPOINT ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && ros2 launch tortoisebot_bringup bringup.launch.py use_sim_time:=True"]