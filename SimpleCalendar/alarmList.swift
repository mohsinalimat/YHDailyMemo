//
//  alarmList.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 20..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

struct alarmList{
    var identifier: String
    var title: String
    var text: String
    var date: String
    
    init(){
        identifier = ""
        title = ""
        text = ""
        date = ""
    }
    
    init(identifier: String, title: String, text: String){
        self.identifier = identifier
        self.title = title
        self.text = text
        
        let dateArray = title.components(separatedBy: " ")
        self.date = "\(dateArray[1])"
    }
}
