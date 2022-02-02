set(SRC main.cpp)

qtquick_compiler_add_resources(RESOURCES qml/glacier-calendar.qrc)

add_executable(glacier-calendar ${SRC} ${RESOURCES})


target_link_libraries(glacier-calendar
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
        Glacier::App)

install(TARGETS glacier-calendar RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
