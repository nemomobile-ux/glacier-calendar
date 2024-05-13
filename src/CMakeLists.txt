set(SRC main.cpp)

qt_add_resources(RESOURCES qml/glacier-calendar.qrc)

add_executable(glacier-calendar ${SRC} ${RESOURCES})


target_link_libraries(glacier-calendar
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Glacier::App)

install(TARGETS glacier-calendar RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
