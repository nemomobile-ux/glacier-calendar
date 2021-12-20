cmake_minimum_required(VERSION 3.6.0)

project(glacier-calendar
        VERSION 0.1
        DESCRIPTION "The Glacier calendar application")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(FeatureSummary)
include(GNUInstallDirs)

set(QT_MIN_VERSION "5.12.0")
find_package(Qt5 COMPONENTS Gui Qml Quick LinguistTools REQUIRED)
find_package(Glacier COMPONENTS App REQUIRED)

add_subdirectory(src)

# Translations
file(GLOB TS_FILES translations/*.ts)
qt5_add_translation(QM_FILES ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES})
add_dependencies(glacier-calendar translations)

install(FILES ${QM_FILES}
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calendar/translations)

install(FILES glacier-calendar.desktop
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications)
install(DIRECTORY icons
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-calendar)
