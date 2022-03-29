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
import Nemo.Dialogs 1.0

import Nemo.Configuration 1.0
import org.nemomobile.calendar 1.0

Item{
    id: agendaViewPage
    anchors.fill: parent

    property date startAgendaDate: new Date()

    ConfigurationValue {
        id: agendaAreaConfig
        key: "/home/glacier/calendar/agendaArea"
        defaultValue: 30
    }

    AgendaModel{
        id: agendaModel
        startDate: app.removeTime(startAgendaDate)
        endDate: QtDate.addDays(startAgendaDate, agendaAreaConfig.value)
    }


    Label{
        anchors.centerIn: parent
        text: qsTr("No events")
        visible: agendaModel.count == 0
    }

    QueryDialog {
         id: deleteDialog
         visible: false
         property variant event;

         inline: true;
         cancelText: qsTr("Cancel")
         acceptText: qsTr("Delete")
         headingText: qsTr("Are you sure you want to delete event?")

         icon: "image://theme/trash"

         onAccepted: {
             event.deleteEvent();
         }
         onSelected: {
             deleteDialog.close()
         }
     }


    ListView{
        id: agendaEventsListView
        anchors.fill: parent
        model: agendaModel
        delegate: ListViewItemWithActions {

            property string relativeDate: app.formateDateRelative(model.event.startTime);

            showNext: false;
            iconVisible: false;
            label: model.event.displayLabel
            description: ((relativeDate != "") ? (relativeDate + " ") : "")
                         + app.formatTime(model.event.startTime)+" - " + app.formatTime(model.event.endTime)

            actions: [
                ActionButton {
                    iconSource: "image://theme/trash"
                    onClicked: {
                        deleteDialog.event = model.event;
                        deleteDialog.open();
                    }
                }

            ]

            Rectangle {
                id: eventColor
                width: height
                height: parent.height/2
                radius: width/2
                color: model.event.color
                anchors.right: parent.right
                anchors.margins: Theme.itemSpacingLarge
                anchors.verticalCenter: parent.verticalCenter
            }


            onClicked: {
                pageStack.push(Qt.resolvedUrl("AddEventPage.qml"), { oldEvent: model.event })
            }

        }

    }
}
