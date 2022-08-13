cmake_minimum_required(VERSION 3.18)

project(SimplePlayer VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick Gui REQUIRED)

qt_add_executable(splayer
  SimplePlayer/SimplePlayer.cpp
)

qt_add_qml_module(splayer
  URI SimplePlayer
  VERSION 1.0
  QML_FILES
    SimplePlayer/SimplePlayer.qml
  SOURCES
    SimplePlayer/SimplePlayer.cpp
)

target_link_libraries(splayer
  PRIVATE
    Qt6::Gui
    Qt6::Quick
)
