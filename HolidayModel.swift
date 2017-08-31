//
//  HolidayModel.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 15..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

func getHoliday ( date: NSDate) -> String? {
    
    let aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let selectedDate = formatter.string(from: date as Date)
    
    
    if aplicationDelegate.holiday == "KOREA" {
        //MARK: If set up as Korean Holiday
        let koreanHoliday = koreaHoliday()
        if let result = koreanHoliday.dates[selectedDate] {
            return result
        }
    } else if aplicationDelegate.holiday == "AMERICA" {
        //MARK: If set up as AMERICA Holiday
        let americanHoliday = USAHoliday()
        if let result = americanHoliday.dates[selectedDate] {
            return result
        }
    }
    return nil
}
