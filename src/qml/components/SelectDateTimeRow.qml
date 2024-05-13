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

Row{
    id: dateTimeRow
    property date selectedDate: new Date()
    property bool selectTime: true

    spacing: Theme.itemSpacingSmall

    Row {
        id: selectDateRow
        height: parent.height
        spacing: Theme.itemSpacingSmall
        width: parent.width/2 - spacing

        Image {
            id: selectDateImage
            height: selectDateLabel.height-Theme.itemSpacingSmall*2
            width: height
            source: "image://theme/calendar-alt"

            anchors.bottom: parent.bottom
        }

        TextField{
            id: selectDateLabel
            text: app.formatDate(selectedDate)
            inputMask: "99.99.99"
            inputMethodHints: Qt.ImhDate
            onEditingFinished: dateTimeRow.formatDate()
            width: parent.width - selectDateImage.width - 2*Theme.itemSpacingSmall
        }
    }

    Row {
        id: selectTimeRow
        height: parent.height
        spacing: Theme.itemSpacingSmall
        width: parent.width/2 - spacing


        Image {
            id: selectTimeImage
            height: selectTimeLabel.height-Theme.itemSpacingSmall*2
            width: height
            source: "image://theme/clock"

            visible: selectTime

            anchors.bottom: parent.bottom
        }

        TextField{
            id: selectTimeLabel
            text: app.formatTime(selectedDate)

            visible: selectTime
            inputMask: "99:99"
            inputMethodHints: Qt.ImhTime
            width: parent.width - selectTimeImage.width - 2*Theme.itemSpacingSmall


            onEditingFinished: dateTimeRow.formatDate()
        }
    }

    function formatDate() {
        var fDate = selectDateLabel.text.split(".");
        var fTime = selectTimeLabel.text.split(":");
        var nD = new Date()
        nD.setDate(fDate[0])
        nD.setMonth(fDate[1]-1)
        nD.setFullYear("20"+fDate[2])
        nD.setHours(fTime[0])
        nD.setMinutes(fTime[1])
        nD.setSeconds(0)

console.log(nD)

        selectedDate = nD
    }
}
