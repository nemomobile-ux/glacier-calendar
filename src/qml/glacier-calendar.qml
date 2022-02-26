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

import "pages"

ApplicationWindow {
    id: app

    property variant accountItem

    initialPage: Component {
        CalendarViewPage {
            id: calendarViewPage
        }
    }

    function formatTime(date) {
        var hh = date.getHours();
        if (hh < 10) hh = '0'+hh;

        var mm = date.getMinutes()
        if(mm < 10) mm = '0' + mm;

        return hh + ":" + mm;
    }

    function formatDate(date) {
        var dd = date.getDate();
        if (dd < 10) dd = '0' + dd;

        var mm = date.getMonth() + 1;
        if (mm < 10) mm = '0' + mm;

        var yy = date.getFullYear() % 100;
        if (yy < 10) yy = '0' + yy;

        return dd + '.' + mm + '.' + yy;
    }

    /**
      * returns "Today", Day of week when date is less than week in future, or date
      */

    function formateDateRelative(date) {
        var now = new Date();
        if (date.getDate() === now.getDate()) {
            return qsTr("Today")
        } else {

            var difference_in_time = date.getTime() - now.getTime();

            if (difference_in_time < 0) { // in past
                return formatDate(date)
            }

            // To calculate the no. of days between two dates
            var difference_in_days = difference_in_time / (1000 * 3600 * 24);

            if (difference_in_days < 7) {
                return date.toLocaleString(Qt.locale(),'dddd')
            }


            return formatDate(date)
        }
    }


    function removeTime(date) {
        return new Date(date.getFullYear(), date.getMonth(), date.getDate())
    }

    function compareDate(d1,d2) {
        if(d1.getFullYear() === d2.getFullYear() &&
                d1.getMonth() === d2.getMonth() &&
                d1.getDate() === d2.getDate()) {
            return true
        }
        return false
    }
}
