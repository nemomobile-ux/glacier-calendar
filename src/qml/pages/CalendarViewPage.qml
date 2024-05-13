/*
 * Copyright (C) 2021-2024 Chupligin Sergey <neochapay@gmail.com>
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

import QtQuick
import QtQuick.Controls

import Nemo
import Nemo.Controls

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
                onClicked: {
                    if (mainViewLoader.item.viewedDate !== undefined) {
                        var d = new Date(mainViewLoader.item.viewedDate);
                        var now = new Date();
                        d.setHours(now.getHours()+1)
                        pageStack.push(Qt.resolvedUrl("AddEventPage.qml"), {curentDate: d});
                    } else {
                        pageStack.push(Qt.resolvedUrl("AddEventPage.qml"));
                    }
                }
            }
        ]

        drawerLevels: [
            ButtonRow {
                id: viewChecked
                model: ListModel {
                    id: viewsModel
                    ListElement {
                        pageName: "day"
                        name: qsTr("day")
                        dayCount: 1
                    }
                    ListElement {
                        pageName: "week"
                        name: qsTr("week")
                        dayCount: 7
                    }
                    ListElement {
                        pageName: "month"
                        name: qsTr("month")
                        dayCount: 30
                    }
                    ListElement {
                        pageName: "year"
                        name: qsTr("year")
                        dayCount: 365
                    }
                    ListElement {
                        pageName: "agenda"
                        name: qsTr("agenda")
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
        mainViewLoader.source = "qrc:/pages/"+viewsModel.get(viewChecked.currentIndex).pageName+"ViewPage.qml"
        dayViewConfig.value = viewsModel.get(viewChecked.currentIndex).dayCount
    }
}
