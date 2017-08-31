//
//  realmObjects.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 9..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import RealmSwift

class dailyMemo: Object {
    dynamic var createdDate = ""
    dynamic var lunaDate = ""
    dynamic var text = ""
    
    override static func primaryKey() -> String? {
        return "createdDate"
    }
}

class monthlyMemo: Object {
    dynamic var month = ""
    dynamic var text = ""
    
    override static func primaryKey() -> String? {
        return "month"
    }
}

class setting: Object {
    dynamic var setting = "setting"
    
    dynamic var lock = false
    dynamic var password = ""
    dynamic var holiday = ""
    dynamic var lunarCalendar = false
    
    override static func primaryKey() -> String? {
        return "setting"
    }
}









