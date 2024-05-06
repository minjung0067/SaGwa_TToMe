//
//  DateHelper.swift
//
//  날짜, 시간
//
//  Created by Minjung Lee on 4/15/24.
//

import Foundation

extension Date {
    func descriptiveString(dateStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        //formatter.dateStyle = dateStyle
        
        
        let daysBetween = self.daysBetween(date: Date())
        
        
        if daysBetween == 0 {
            return "오늘"
        }
        else if daysBetween == 1 {
            return "어제"
        }
        else if daysBetween < 5 {
            let weekdayIndex = Calendar.current.component(.weekday, from: self) - 1
            return formatter.weekdaySymbols[weekdayIndex]
        }
        return formatter.string(from: self)
    }
    
    func daysBetween(date: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        if let daysBetween = calendar.dateComponents([.day], from: date1, to: date2).day {
            return daysBetween
        }
        return 0
    }
}
