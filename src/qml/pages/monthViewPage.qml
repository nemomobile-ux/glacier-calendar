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

Item{
    id: monthViewPage
    anchors.fill: parent

    function getFirstDay(date) {
        return new Date(date.getFullYear(), date.getMonth(), 1);
    }

    function getLastDay(date) {
        return new Date(date.getFullYear(), date.getMonth() + 1, 0);
    }

    AgendaModel{
        id: agendaModel
        startDate: getFirstDay(new Date(datePicker.selectedDate));
        endDate: getLastDay(new Date(datePicker.selectedDate));
        onUpdated: {
            updateMonthView()
        }
    }

    DatePicker{
        id: datePicker
        height: parent.height
        onDateSelect:  {
            mainViewLoader.setSource ("qrc:/pages/dayViewPage.qml",{viwedDate: date})
            // FIXME not sure how to work with ButtonRow
            viewChecked.currentIndex = 0;


        }

        dayDelegate: MonthViewDataPickerDelegate {
            id: datePickerDelegate
            numberOfEvents: getEvents(dateOfDay)
        }
    }

    property variant monthData: [];
//    onMonthDataChanged: { // TODO, is the binding done automatically?
//        datePicker.numberOfEvents = getEvents(dateOfDay)
//    }

    function updateMonthView() {
        var data = []
        for (var i = 0; i < agendaModel.count; i++) {
            var event = agendaModel.get(i, AgendaModel.EventObjectRole);
            var day = event.startTime.getDate()
            if (typeof data[day] === "undefined") {
                data[day] = [ event.color ]
            } else {
                data[day].push(event.color);
            }
        }
//        console.log(JSON.stringify(data))
        monthData = data
    }

    function getEvents(date) {
        var day = date.getDate();
        var colors = (monthData[day] !== undefined) ? monthData[day]: [];
//        console.log( day + " " + colors.length + " " + colors )
        return colors.length;
    }

}
