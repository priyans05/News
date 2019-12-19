//
//  Date.swift
//  News
//
//  Created by PRIYANS on 19/12/19.
//  Copyright © 2019 PRIYANS. All rights reserved.
//

import Foundation

extension Date {
    
    mutating func changeDays(by days: Int) {
        self = Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    mutating func getToDateAsString() -> String {
        self.changeDays(by: -1)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    mutating func getFromDateAsString() -> String {
        self.changeDays(by: -30)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
        
    }
}
