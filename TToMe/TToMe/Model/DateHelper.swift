//
//  DateHelper.swift
//
//  채팅 시 보여지는 날짜의 format을 다룸
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
        
        // MARK: - 특정 날짜에서 날짜 대신 보여줄 문구
        if daysBetween == 0 {
            return "오늘"
        }
        else if daysBetween == 1 {
            return "어제"
        }
        // X요일
        else if daysBetween < 5 {
            let weekdayIndex = Calendar.current.component(.weekday, from: self) - 1
            return formatter.weekdaySymbols[weekdayIndex]
        }
        return formatter.string(from: self)
    }
    
    // MARK: - 오늘과 채팅에 쓰인 날 사이의 간격 계산하는 함수
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
