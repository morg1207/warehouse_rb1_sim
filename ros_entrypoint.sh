#!/bin/bash
set -e

# Configurar espacio de trabajo
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source /sim_ros2_ws/install/setup.bash

ros2 launch the_construct_office_gazebo warehouse_rb1.launch.xml
# Mantener el contenedor activo
#exec sleep infinity
exec "$@"