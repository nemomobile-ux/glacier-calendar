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

import "../components"

Page{
    id: addEventPage

    property var newEvent: Calendar.createNewEvent();
    property var oldEvent;
    property date curentDate: new Date()

    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Add event")
        showBackButton: true
    }

    Flickable{
        id: mainContent
        anchors.fill: parent
        contentHeight: mainColumn.childrenRect.height
        contentWidth: parent.width;


        Column{
            id: mainColumn
            width: addEventPage.width - Theme.itemSpacingSmall*2
            spacing: Theme.itemSpacingSmall
            anchors{
                left: parent.left
                leftMargin: Theme.itemSpacingSmall
            }

            Label{
                id: summaryLabel
                text: qsTr("Summary")
                width: parent.width
            }

            TextField{
                id: summary
                width: parent.width
                text: (oldEvent !== undefined) ? oldEvent.displayLabel : "";
            }

            Label{
                id: startLabel
                text: qsTr("Start")
                width: parent.width
            }

            SelectDateTimeRow{
                id: startDateTimeRow
                width: startLabel.width
                height: startLabel.height

                selectedDate: (oldEvent !== undefined) ? oldEvent.startTime : curentDate;
                selectTime: !allDay.checked
            }

            Label{
                id: endLabel
                text: qsTr("End")
                width: parent.width
            }

            SelectDateTimeRow{
                id: endDateTimeRow
                width: startLabel.width
                height: startLabel.height

                selectedDate: (oldEvent !== undefined) ? oldEvent.endTime :  new Date(startDateTimeRow.selectedDate.getTime() + 60*60*1000)
                selectTime: !allDay.checked
            }


            CheckBox{
                id: allDay
                text: qsTr("All day")
                checked: (oldEvent !== undefined) ? oldEvent.allDay : false;
            }

            Label{
                id: descriptionLabel
                text: qsTr("Description")
                width: parent.width
            }

            TextField{
                id: description
                width: parent.width
                text: (oldEvent !== undefined) ? oldEvent.description : ""
            }

            Label{
                id: locationLabel
                text: qsTr("Location")
                width: parent.width
            }

            TextField{
                id: location
                width: parent.width
                text: (oldEvent !== undefined) ? oldEvent.location: "";
            }

            Button{
                id: saveButton
                width: parent.width
                text: qsTr("Save event")
                enabled: summaryLabel.text != ""
                onClicked: {
                    if (oldEvent !== undefined) {
                        oldEvent.deleteEvent();
                    }
                    newEvent.displayLabel = summary.text
                    newEvent.setStartTime(startDateTimeRow.selectedDate, Qt.LocalTime)
                    newEvent.setEndTime(endDateTimeRow.selectedDate, Qt.LocalTime)
                    newEvent.allDay = allDay.checked
                    newEvent.description = description.text
                    newEvent.location = location.text
                    newEvent.calendarUid = Calendar.defaultNotebook

                    console.log("??????????????"+startDateTimeRow.selectedDate)

                    newEvent.save()

                    pageStack.pop()
                }
            }
        }
    }

    ScrollDecorator{
        flickable: mainContent
    }

}
