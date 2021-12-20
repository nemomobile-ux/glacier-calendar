set(SRC main.cpp
    calendarevent.cpp
    calendarevent.h)

add_executable(glacier-calendar ${SRC})

target_link_libraries(glacier-calendar
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
        Glacier::App
        KF5::CalendarCore)

install(TARGETS glacier-calendar RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calendar)
