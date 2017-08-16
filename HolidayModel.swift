//
//  HolidayModel.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 15..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation

func getHoliday ( date: NSDate) -> String? {

    let koreanHoliday = koreaHoliday()
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let selectedDate = formatter.string(from: date as Date)

    //MARK: If set up as Korean Holiday
    if let result = koreanHoliday.dates[selectedDate] {
        return result
    }
    
    return nil
}
