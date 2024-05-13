/****************************************************************************************
**
** Copyright (C) 2021-2024 Chupligin Sergey <neochapay@gmail.com>
** All rights reserved.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the author nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick
import QtQuick.Controls

import Nemo
import Nemo.Controls

import Nemo.UX.Models 1.0

Item{
    id: dayCell

    width: parent.width/7
    height: parent.height/6

    property int numberOfEvents: 0;
    property bool isCurrentDay: model.isCurrentDay
    property date dateOfDay: model.dateOfDay

    function setColor(model)
    {
        var color = Theme.textColor;
        /*If weekend*/
        if(model.dateOfDay.getDay() === 0 || model.dateOfDay.getDay() === 6)
        {
            if(model.isCurrentDay)
            {
                color = Theme.textColor
            }
            else
            {
                color = Theme.accentColor;
            }
        }

        if(model.isOtherMonthDay)
        {
            color = Theme.fillDarkColor
        }
        return color;
    }

    Rectangle{
        width: parent.width
        height: parent.height
        color: Theme.accentColor
        visible: model.isCurrentDay
    }
    Rectangle {
        width: parent.width
        height: parent.height
        color: Theme.fillDarkColor
        visible: mouse.pressed
    }

    Label{
        text: model.dateOfDay.getDate()
        anchors.centerIn: parent
        color: setColor(model)
        font.pixelSize: (parent.height*0.45 < Theme.fontSizeLarge) ? parent.height*0.45 : Theme.fontSizeLarge
    }

    property int bulletWidth: (dayCell.width/10)-2
    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10;
        spacing: 2
        height: bulletWidth + 2*spacing
        width: model.count * bulletWidth
        visible: !model.isOtherMonthDay
        Repeater {
            anchors.bottom: parent.bottom
            anchors.left: parent.left;
            anchors.right: parent.right

            model: numberOfEvents
            delegate: Rectangle {
                color: isCurrentDay ? Theme.textColor: Theme.accentColor;
                width: bulletWidth
                height: width
                radius: width/2

            }
        }
    }




    MouseArea{
        id: mouse
        anchors.fill: parent
        onClicked: {
            datePicker.dateSelect(model.dateOfDay)
        }
    }
}
