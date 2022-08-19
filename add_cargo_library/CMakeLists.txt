cmake_minimum_required(VERSION 3.22)
project(add_cargo_library NONE)

find_package(ament_cmake REQUIRED)

install(
  DIRECTORY cmake
  DESTINATION share/${PROJECT_NAME}
)

ament_package(
  CONFIG_EXTRAS "add_cargo_library-extras.cmake"
)
