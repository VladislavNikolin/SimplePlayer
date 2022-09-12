add_library(OnvifProxy
  OnvifCamera.cpp
  OnvifCameraModel.cpp
  OnvifAuthorizedCameraFilterModel.cpp
)

target_link_libraries(OnvifProxy
  PRIVATE
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
  PUBLIC
    onvif_static
)

target_include_directories(OnvifProxy
  INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)
