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


#ifndef EVENT_H
#define EVENT_H

#include <QObject>
#include <kcalcore/event.h>
#include <kcalcore/calendar.h>

class CalendarEvent : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool correct READ correct NOTIFY correctChanged)
    Q_PROPERTY(QDateTime startDateTime READ startDateTime WRITE setStartDateTime NOTIFY startDateTimeChanged)
    Q_PROPERTY(QDateTime endDateTime READ endDateTime WRITE setEndDateTime NOTIFY endDateTimeChanged)
    Q_PROPERTY(QString summary READ summary WRITE setSummary NOTIFY summaryChanged)
    Q_PROPERTY(bool allDay READ allDay WRITE setAllDay NOTIFY allDayChanged)
    Q_PROPERTY(QString descrption READ descrption WRITE setDescrption NOTIFY descrptionChanged)
    Q_PROPERTY(QString location READ location WRITE setLocation NOTIFY locationChanged)

public:
    explicit CalendarEvent(QObject *parent = nullptr);
    bool correct() {return m_correct;}
    QDateTime startDateTime() {return m_startDateTime;}
    QDateTime endDateTime() {return m_endDateTime;}
    QString summary() {return m_summary;}
    bool allDay() {return m_allDay;}
    QString descrption() {return m_descrption;}
    QString location() {return m_location;}

    void setStartDateTime(QDateTime startDateTime);
    void setEndDateTime(QDateTime endDateTime);
    void setSummary(QString summary);
    void setAllDay(bool allDay);
    void setDescrption(QString descrption);
    void setLocation(QString location);

    Q_INVOKABLE void save();


signals:
    void saved();
    void correctChanged();
    void startDateTimeChanged();
    void endDateTimeChanged();
    void summaryChanged();
    void allDayChanged();
    void descrptionChanged();
    void locationChanged();

private:
    KCalendarCore::Event::Ptr m_event;
    KCalendarCore::Calendar::Ptr m_calendar;

    QDateTime m_startDateTime;
    QDateTime m_endDateTime;
    QString m_summary;
    bool m_allDay;
    QString m_descrption;
    QString m_location;

    void calcCorrect();
    bool m_correct;
};

#endif // EVENT_H
