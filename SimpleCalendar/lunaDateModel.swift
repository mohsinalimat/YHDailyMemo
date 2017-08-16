//
//  lunaDateModel.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 14..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

func lunaDate( Soldate: NSDate)-> String? {
    
    let lunaday = luna()
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let selectedDate = formatter.string(from: Soldate as Date)
    
    //MARK: If set up as Korean Holiday
    if let result = lunaday.dates[selectedDate] {
        let index = result.index(result.startIndex, offsetBy: 5)
        return result.substring(to: index)
    }
    
    return nil
}









