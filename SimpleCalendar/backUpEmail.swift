//
//  backUpEmail.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 31..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

func realmToString() -> String {
    let array = realmToArray()
    var result = "[Daily Memo Back Up] \n\n============================\n"
    
    for dailyMemo in array {
        result.append(dailyMemo)
        result.append("\n")
        result.append("============================")
        result.append("\n")
    }
    return result
}
