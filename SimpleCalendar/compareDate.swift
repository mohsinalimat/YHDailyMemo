//
//  compareDate.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 9. 2..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation


func checkSelectedDateIsBeforeThanToday(_ date: Date) -> Bool {
    if  Calendar(identifier: .gregorian).isDate(Date(), inSameDayAs: date) {
        return true
    }
    
    if date.description > Date().description {
        return true
    } else {
        return false
    }
}
