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

Row{
    id: dateTimeRow
    property date selectedDate: new Date()
    property bool selectTime: true

    spacing: Theme.itemSpacingSmall

    Row {
        id: selectDateRow
        height: parent.height
        spacing: Theme.itemSpacingSmall

        Image {
            id: selectDateImage
            height: parent.height-Theme.itemSpacingSmall*2
            width: height
            source: "image://theme/calendar-alt"

            anchors.verticalCenter: parent.verticalCenter
        }

        TextField{
            id: selectDateLabel
            text: app.formatDate(selectedDate)
            inputMask: "9D.9D.DD"

            onEditingFinished: dateTimeRow.formatDate()
        }
    }

    Row {
        id: selectTimeRow
        height: parent.height
        spacing: Theme.itemSpacingSmall

        Image {
            id: selectTimeImage
            height: parent.height-Theme.itemSpacingSmall*2
            width: height
            source: "image://theme/clock"

            visible: selectTime

            anchors.verticalCenter: parent.verticalCenter
        }

        TextField{
            id: selectTimeLabel
            text: app.formatTime(selectedDate)

            visible: selectTime
            inputMask: "99:99"

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
