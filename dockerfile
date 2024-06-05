# Start from ROS base image
FROM ros:humble-ros-base-jammy

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
  libgazebo-dev \
  ros-humble-ros2-controllers-* \
  ros-humble-gazebo-ros-* \
  ros-humble-gazebo-ros2-* \
  ros-humble-rviz2 \
  ros-humble-topic-tools \
  ros-humble-ros2-controllers \
  && rm -rf /var/lib/apt/lists/*

# Custom cache invalidation
ARG CACHEBUST=1
# Create a volume for ROS packages
RUN git clone https://github.com/morg1207/warehouse_rb1_sim.git /sim_ros2_ws/src


#COPY ./ros_entrypoint.sh /ros_entrypoint.sh

# Build the Catkin workspace
RUN source /opt/ros/humble/setup.bash \
    && cd /sim_ros2_ws \
    && colcon build
COPY ./ros_entrypoint.sh /ros_entrypoint.sh


# Set the entry point to start the ROS launch file
ENTRYPOINT ["/bin/bash", "-c", "source /ros_entrypoint.sh"]
