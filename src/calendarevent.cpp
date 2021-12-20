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

#include "calendarevent.h"

CalendarEvent::CalendarEvent(QObject *parent)
    : QObject{parent}
    , m_allDay(false)
{
    m_event = KCalendarCore::Event::Ptr(new KCalendarCore::Event());
    connect(this, &CalendarEvent::startDateTimeChanged, this, &CalendarEvent::calcCorrect);
    connect(this, &CalendarEvent::endDateTimeChanged, this, &CalendarEvent::calcCorrect);
    connect(this, &CalendarEvent::summaryChanged, this, &CalendarEvent::calcCorrect);
}

void CalendarEvent::setStartDateTime(QDateTime startDateTime)
{
    if(startDateTime != m_startDateTime) {
        m_startDateTime = startDateTime;
        emit startDateTimeChanged();
    }
}

void CalendarEvent::setEndDateTime(QDateTime endDateTime)
{
    if(endDateTime != m_endDateTime) {
        m_endDateTime = endDateTime;
        emit endDateTimeChanged();
    }
}

void CalendarEvent::setSummary(QString summary)
{
    if(summary != m_summary) {
        m_summary = summary;
        emit summaryChanged();
    }
}

void CalendarEvent::setAllDay(bool allDay)
{
    if(allDay != m_allDay) {
        m_allDay = allDay;
        emit allDayChanged();
    }
}

void CalendarEvent::setDescrption(QString descrption)
{
    if(descrption != m_descrption) {
        m_descrption = descrption;
        emit descrptionChanged();
    }
}

void CalendarEvent::setLocation(QString location)
{
    if(location != m_location) {
        m_location = location;
        emit locationChanged();
    }
}

void CalendarEvent::save()
{
    if(!m_correct) {
        return;
    }

    m_event->setDtStart(m_startDateTime);
    m_event->setDtEnd(m_endDateTime);
    m_event->setSummary(m_descrption);
    m_event->setAllDay(m_allDay);
    m_event->setDescription(m_descrption);
    m_event->setLocation(m_location);

    m_calendar->addEvent(m_event);
}

void CalendarEvent::calcCorrect()
{
    bool correct = !m_startDateTime.isNull()
            && !m_endDateTime.isNull()
            && !m_summary.isNull();

    if(correct != m_correct) {
        m_correct = correct;
        emit correctChanged();
    }
}
