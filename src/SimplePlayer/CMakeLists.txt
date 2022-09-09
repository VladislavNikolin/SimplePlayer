qt_add_executable(splayer
  SimplePlayer.cpp
)

set_target_properties(splayer PROPERTIES
  WIN32_EXECUTABLE TRUE
)

qt_add_qml_module(splayer
  URI SimplePlayer
  VERSION ${CMAKE_PROJECT_VERSION}
  QML_FILES
    SimpleCamera.qml
    SimpleLoginDialog.qml
    SimplePlayer.qml
  SOURCES
    SimplePlayer.cpp
)

target_link_libraries(splayer
  PRIVATE
    Qt6::Gui
    Qt6::Quick
    OnvifProxy
)
