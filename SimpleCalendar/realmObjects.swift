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
    dynamic var weather = ""
    dynamic var createdLocation = ""
    dynamic var text = ""
    
    override static func primaryKey() -> String? {
        return "createdDate"
    }
}










