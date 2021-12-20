/*
 * Copyright (C) 2021 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

import QtQuick 2.6

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import Nemo.Configuration 1.0

Page {
    id: calendarViewPage

    ConfigurationValue {
        id: dayViewConfig
        key: "/home/glacier/calendar/dayView"
        defaultValue: 30
    }

    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Calendar")
        tools: [
            ToolButton {
                iconSource: "image://theme/cog"
                showCounter: false
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            },
            ToolButton {
                iconSource: "image://theme/plus"
                showCounter: false
                onClicked: pageStack.push(Qt.resolvedUrl("AddEventPage.qml"))
            }
        ]

        drawerLevels: [
            ButtonRow {
                id: viewChecked
                model: ListModel {
                    id: viewsModel
                    ListElement {
                        name: qsTr("day")
                        dayCount: 1
                    }
                    ListElement {
                        name: qsTr("week")
                        dayCount: 7
                    }
                    ListElement {
                        name: qsTr("month")
                        dayCount: 30
                    }
                    ListElement {
                        name: qsTr("year")
                        dayCount: 365
                    }
                    ListElement {
                        name: qsTr("agena")
                        dayCount: -1
                    }
                }

                onCurrentIndexChanged: selectView()

                Component.onCompleted:{
                    switch (dayViewConfig.value) {
                    case 1:
                        viewChecked.currentIndex = 0
                        break
                    case 7:
                        viewChecked.currentIndex = 1
                        break
                    case 30:
                        viewChecked.currentIndex = 2
                        break
                    case 365:
                        viewChecked.currentIndex = 3
                        break
                    default:
                        viewChecked.currentIndex = 4
                    }
                }
            }
        ]
    }

    Loader{
        id: mainViewLoader
        anchors.fill: parent
    }

    function selectView() {
        mainViewLoader.source = "/usr/share/glacier-calendar/qml/pages/"+viewsModel.get(viewChecked.currentIndex).name+"ViewPage.qml"
    }
}
