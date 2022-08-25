add_library(OnvifProxy
  OnvifCamera.cpp
  OnvifCameraModel.cpp
)

target_link_libraries(OnvifProxy
  PRIVATE
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
  PUBLIC
    onvif
)

target_include_directories(OnvifProxy
  INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)
