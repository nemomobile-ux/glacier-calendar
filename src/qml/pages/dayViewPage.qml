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

import org.nemomobile.calendar 1.0

Item{
    id: dayViewPage
    anchors.fill: parent

    property date viwedDate: new Date()
    property bool isTooday: compareDate(new Date(), dayViewPage.viwedDate)


    AgendaModel{
        id: agendaModel
        startDate: viwedDate
        endDate: QtDate.addDays(viwedDate, 1)
    }


    ListModel {
        id : hourModel
        ListElement {hour : "00:00"}
        ListElement {hour : "01:00"}
        ListElement {hour : "02:00"}
        ListElement {hour : "03:00"}
        ListElement {hour : "04:00"}
        ListElement {hour : "05:00"}
        ListElement {hour : "06:00"}
        ListElement {hour : "07:00"}
        ListElement {hour : "08:00"}
        ListElement {hour : "09:00"}
        ListElement {hour : "10:00"}
        ListElement {hour : "11:00"}
        ListElement {hour : "12:00"}
        ListElement {hour : "13:00"}
        ListElement {hour : "14:00"}
        ListElement {hour : "15:00"}
        ListElement {hour : "16:00"}
        ListElement {hour : "17:00"}
        ListElement {hour : "18:00"}
        ListElement {hour : "19:00"}
        ListElement {hour : "20:00"}
        ListElement {hour : "21:00"}
        ListElement {hour : "22:00"}
        ListElement {hour : "23:00"}
    }

    Component.onCompleted: {
        var currentDate = new Date();
        if(isTooday) {
            currentTimeInd.visible = true
            hourList.positionViewAtIndex(dayViewPage.viwedDate.getHours(), ListView.Center)
        }
        currentTimeLine.y = calculateYTime(new Date())
    }

    ListView {
        id: hourList
        clip: true
        anchors.fill: parent

        model: hourModel

        delegate: Column {
            id: hourColumn
            width: hourList.width
            height: Theme.itemHeightMedium

            Rectangle {
                height : 1
                width : hourList.width
                color : Theme.fillDarkColor
            }

            Row {
                spacing: 4
                Rectangle {
                    width: Theme.itemWidthSmall
                    height: hourColumn.height-1
                    color: Theme.backgroundColor

                    Text {
                        text: hour
                        id: hourText
                        font.pointSize: Theme.fontSizeTiny
                        color: Theme.textColor
                        anchors{
                            left: parent.left
                            leftMargin: Theme.itemSpacingSmall
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }


        ScrollDecorator{
            flickable: hourList
        }

        Item{
            id: currentTimeLine
            width: hourList.width
            visible: isTooday
            parent: hourList.contentItem

            z: 1000

            Rectangle{
                id: currentTimeInd
                height : 1
                width : hourList.width
                color : Theme.accentColor
            }
        }

        Repeater{
            id: eventsRepeater
            parent: hourList.contentItem
            model: agendaModel

            delegate: Rectangle{
                id: eventView
                color: model.event.color
                border.color: Theme.textColor
                width: Theme.itemWidthMedium
                height: 100
                y: calculateYTime(model.event.startTime)
                x: Theme.itemWidthSmall

                Label{
                    id: eventLabel
                    text: model.event.displayLabel
                    width: eventView.width-Theme.itemSpacingExtraSmall*2

                    anchors{
                        top: parent.top
                        topMargin: Theme.itemSpacingExtraSmall
                        left: parent.left
                        leftMargin: Theme.itemSpacingExtraSmall
                    }
                }
            }
        }
    }

    function calculateYTime(date) {
        var currentHour = date.getHours();
        var currentMin = date.getMinutes();

        var hourY = hourList.contentItem.height/24
        var minY = hourY/60

        return hourY*currentHour+minY*currentMin
    }

    Timer {
        interval: 1000;
        repeat: true
        running: isTooday
        onTriggered: {
            currentTimeLine.y = calculateYTime(new Date())
        }
    }
}
