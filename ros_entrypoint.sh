#!/bin/bash
set -e

echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source /sim_ros2_ws/install/setup.bash
ros2 launch the_construct_office_gazebo warehouse_rb1.launch.xml

exec "$@"