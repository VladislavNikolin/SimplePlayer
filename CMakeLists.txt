cmake_minimum_required(VERSION 3.19)

project(SimplePlayer VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Core Gui Qml Quick REQUIRED)

# 3rdparty projects
add_subdirectory(3rdparty/libonvif)

# local project
add_subdirectory(src/OnvifProxy)
add_subdirectory(src/SimplePlayer)
