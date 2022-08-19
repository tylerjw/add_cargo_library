cmake_minimum_required(VERSION 3.22)
project(add_cargo_library_example)

find_package(ament_cmake REQUIRED)
find_package(add_cargo_library REQUIRED)

add_cargo_library(mul_rs)

add_executable(app src/test.cpp)
target_include_directories(app PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>)
target_compile_features(app PUBLIC c_std_99 cxx_std_17)
target_link_libraries(app mul_rs)

install(TARGETS app
  DESTINATION lib/${PROJECT_NAME})

ament_package()
