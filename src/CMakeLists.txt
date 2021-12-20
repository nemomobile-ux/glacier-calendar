set(SRC main.cpp)

add_executable(glacier-calendar ${SRC})

target_link_libraries(glacier-calendar
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Glacier::App)

install(TARGETS glacier-calendar RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calendar)
