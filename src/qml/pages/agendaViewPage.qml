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
import org.nemomobile.calendar 1.0

Item{
    id: agendaViewPage
    anchors.fill: parent

    property date startAgenaDate: new Date()

    ConfigurationValue {
        id: agendaAreaConfig
        key: "/home/glacier/calendar/agenaArea"
        defaultValue: 30
    }

    AgendaModel{
        id: agendaModel
        startDate: app.removeTime(startAgenaDate)
        endDate: QtDate.addDays(startAgenaDate, agendaAreaConfig.value)
    }


    Label{
        anchors.centerIn: parent
        text: qsTr("No events")
        visible: agendaModel.count == 0
    }

    ListView{
        id: agenaEventsListView
        anchors.fill: parent
        model: agendaModel
        delegate: Item {
            id: eventView
            width: parent.width
            height: Theme.itemHeightLarge

            Rectangle{
                id: eventColor
                width: Theme.itemSpacingSmall
                height: parent.height
                color: model.event.color
            }

            Label{
                id: summary
                anchors{
                    top: parent.top
                    left: eventColor.right
                    leftMargin: Theme.itemSpacingSmall
                }
                text: model.event.displayLabel
            }

            Label{
                id: time
                anchors{
                    top: summary.bottom
                    left: eventColor.right
                    leftMargin: Theme.itemSpacingSmall
                }
                text: app.formatTime(model.event.startTime)+" - " + app.formatTime(model.event.endTime)
                font.pixelSize: Theme.fontSizeTiny
            }
        }
    }
}
