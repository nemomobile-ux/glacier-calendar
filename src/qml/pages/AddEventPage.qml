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
import org.glacier.calendar 1.0

Page{
    id: addEventPage
    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Add event")
        showBackButton: true
    }

    CalendarEvent{
        id: newEvent
        onSaved: {
            pageStack.pop();
        }
    }

    Flickable{
        id: mainContent
        anchors.fill: parent

        ScrollDecorator{
            flickable: mainColumn
        }

        Column{
            id: mainColumn
            width: parent.width - Theme.itemSpacingSmall*2
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
                onEditingFinished: {
                    newEvent.summary = summary.text
                }
            }

            Label{
                id: startLabel
                text: qsTr("Start")
                width: parent.width
            }

            TextField{
                id: start
                width: parent.width
                onEditingFinished: {
                    newEvent.startDateTime = new Date(start.text)
                }
            }

            Label{
                id: endLabel
                text: qsTr("End")
                width: parent.width
            }

            TextField{
                id: end
                width: parent.width
                onEditingFinished: {
                    newEvent.endDateTime = new Date(end.text)
                }
            }

            CheckBox{
                id: allDay
                text: qsTr("All day")
                onCheckedChanged: {
                    newEvent.allDay = allDay.checked
                }
            }

            Button{
                id: saveButton
                width: parent.width
                text: qsTr("Save event")
                enabled: newEvent.correct
                onClicked: {
                    newEvent.save()
                }
            }
        }
    }
}
