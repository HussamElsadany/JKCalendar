//
//  common.swift
//  JKCalendar-Sample
//
//  Created by Joe on 2017/3/10.
//  Copyrhs © 2017年 Joe. All rhss reserved.
//

import UIKit

enum JKCalendarChangeDirection{
    case previous
    case next
}

class JKYear: NSObject {
    let year: Int
    
    init?(year: Int){
        if year < 0{
            return nil
        }
        self.year = year
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? JKYear{
            return object == self
        }else{
            return false
        }
    }
}

func == (lhs: JKYear, rhs: JKYear) -> Bool{
    return lhs.year == rhs.year
}

func != (lhs: JKYear, rhs: JKYear) -> Bool{
    return lhs.year != rhs.year
}

func < (lhs: JKYear, rhs: JKYear) -> Bool{
    return lhs.year < rhs.year
}

func <= (lhs: JKYear, rhs: JKYear) -> Bool{
    return lhs.year <= rhs.year
}

func > (lhs: JKYear, rhs: JKYear) -> Bool{
    return lhs.year > rhs.year
}

func >= (lhs: JKYear, rhs: JKYear) -> Bool{
    return lhs.year >= rhs.year
}

class JKMonth: JKYear {
    let month: Int
    
    init?(year: Int, month: Int){
        if month < 0 || month > 12{
            return nil
        }
        self.month = month
        super.init(year: year)
    }
    
    var next: JKMonth{
        var year = self.year
        var month = self.month + 1
        if month > 12{
            year += 1
            month = 1
        }
        return JKMonth(year: year, month: month)!
    }
    
    var previous: JKMonth{
        var year = self.year
        var month = self.month - 1
        if month < 1{
            year -= 1
            month = 12
        }
        return JKMonth(year: year, month: month)!
    }
    
    var firstDay: JKDay{
        return JKDay(year: year, month: month, day: 1)!
    }
    
    var lastDay: JKDay{
        let date = JKCalendar.calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDay.date)!
        return JKDay(year: date.year, month: date.month, day: date.day)!
    }
    
    var daysCount: Int{
        return lastDay.day
    }
    
    var weeksCount: Int{
        return 5//Int(ceil(Double(daysCount + firstDay.weekday - 1) / 7))
    }
    
    func weeks() -> [JKWeek]{
        var weeks: [JKWeek] = []
        let weekday = firstDay.weekday - 1
        var offsetDay = firstDay.previous(weekday)
        while offsetDay <= self {
            weeks.append(offsetDay.week())
            offsetDay = offsetDay.next(7)
        }
        return weeks
    }
    
    var name: String{
        switch month{
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            fatalError()
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? JKMonth{
            return object == self
        }else{
            return false
        }
    }
}

func == (lhs: JKMonth, rhs: JKMonth) -> Bool{
    return lhs.year == rhs.year && lhs.month == rhs.month
}

func != (lhs: JKMonth, rhs: JKMonth) -> Bool{
    return lhs.year != rhs.year || lhs.month != rhs.month
}

func < (lhs: JKMonth, rhs: JKMonth) -> Bool{
    return lhs.year < rhs.year || (lhs.year == rhs.year && lhs.month < rhs.month)
}

func <= (lhs: JKMonth, rhs: JKMonth) -> Bool{
    return lhs.year < rhs.year || (lhs.year == rhs.year && lhs.month <= rhs.month)
}

func > (lhs: JKMonth, rhs: JKMonth) -> Bool{
    return lhs.year > rhs.year || (lhs.year == rhs.year && lhs.month > rhs.month)
}

func >= (lhs: JKMonth, rhs: JKMonth) -> Bool{
    return lhs.year > rhs.year || (lhs.year == rhs.year && lhs.month >= rhs.month)
}


class JKDay: JKMonth {
    let day: Int
    
    init?(year: Int, month: Int, day: Int){
        guard let _ = JKCalendar.calendar.date(from: DateComponents(timeZone: TimeZone(secondsFromGMT: 0),
                                                         year: year,
                                                         month: month,
                                                         day: day)) else {
            return nil
        }
        self.day = day
        super.init(year: year, month: month)
    }
    
    convenience init(date: Date){
        let year = date.year
        let month = date.month
        let day = date.day
        self.init(year: year, month: month, day: day)!
    }
    
    var date: Date{
        return JKCalendar.calendar.date(from: DateComponents(timeZone: TimeZone(secondsFromGMT: 0),
                                                  year: year,
                                                  month: month,
                                                  day: day))!
    }
    
    var weekday: Int{
        return date.week
    }
    
    func week() -> JKWeek{
        return JKWeek(sunday: self.previous(weekday - 1))
    }
    
    func next(_ count: Int = 1) -> JKDay{
        let components = DateComponents(day: count)
        return JKDay(date: JKCalendar.calendar.date(byAdding: components, to: date)!)
    }
    
    func previous(_ count: Int = 1) -> JKDay{
        let components = DateComponents(day: -count)
        return JKDay(date: JKCalendar.calendar.date(byAdding: components, to: date)!)
    }
    
    func days(until: JKDay) -> [JKDay] {
        let (start, end) = self < until ? (self, until): (until, self)
        
        var days: [JKDay] = [start]
        var offsetDay = start
        
        while offsetDay != end {
            offsetDay = offsetDay.next()
            days.append(offsetDay)
        }
        return days
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? JKDay{
            return object == self
        }else{
            return false
        }
    }
}

func == (lhs: JKDay, rhs: JKDay) -> Bool{
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}

func != (lhs: JKDay, rhs: JKDay) -> Bool{
    return lhs.year != rhs.year || lhs.month != rhs.month || lhs.day != rhs.day
}

func < (lhs: JKDay, rhs: JKDay) -> Bool{
    return lhs.year < rhs.year ||
        (lhs.year == rhs.year && (lhs.month < rhs.month || (lhs.month == rhs.month && lhs.day < rhs.day)))
}

func <= (lhs: JKDay, rhs: JKDay) -> Bool{
    return lhs.year < rhs.year ||
        (lhs.year == rhs.year && (lhs.month < rhs.month || (lhs.month == rhs.month && lhs.day <= rhs.day)))
}

func > (lhs: JKDay, rhs: JKDay) -> Bool{
    return lhs.year > rhs.year ||
        (lhs.year == rhs.year && (lhs.month > rhs.month || (lhs.month == rhs.month && lhs.day > rhs.day)))
}

func >= (lhs: JKDay, rhs: JKDay) -> Bool{
    return lhs.year > rhs.year ||
        (lhs.year == rhs.year && (lhs.month > rhs.month || (lhs.month == rhs.month && lhs.day >= rhs.day)))
}

class JKWeek{
    
    let sunday: JKDay
    
    var monday: JKDay{
        return sunday.next(1)
    }
    
    var tuesday: JKDay{
        return sunday.next(2)
    }
    
    var wednesday: JKDay{
        return sunday.next(3)
    }
    
    var thursday: JKDay{
        return sunday.next(4)
    }
    
    var friday: JKDay{
        return sunday.next(5)
    }
    
    var staturday: JKDay{
        return sunday.next(6)
    }
    
    init(sunday: JKDay){
        self.sunday = sunday
    }
    
    func contains(_ day: JKDay) -> Bool{
        return day >= sunday && day <= staturday
    }
    
}

func == (lhs: JKWeek, rhs: JKWeek) -> Bool{
    return lhs.sunday == rhs.sunday
}

func != (lhs: JKWeek, rhs: JKWeek) -> Bool{
    return lhs.sunday != rhs.sunday
}

extension Date{
    var day: Int{
        return JKCalendar.calendar.component(.day, from: self)
    }
    
    var week: Int{
        return JKCalendar.calendar.component(.weekday, from: self)
    }
    
    var month: Int{
        return JKCalendar.calendar.component(.month, from: self)
    }
    
    var year: Int{
        return JKCalendar.calendar.component(.year, from: self)
    }
}
