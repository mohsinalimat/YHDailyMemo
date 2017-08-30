//
//  monthlyMemoRealmModel.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 29..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import RealmSwift


func realmUpdateMonthlyMemo ( date: NSDate, text: String ) {
    let realm = try! Realm()
    let primaryKey = getPrimaryKeyMonthlyMemo(date: date)
    let result = realm.objects(monthlyMemo.self).filter("month = '\(primaryKey)'")
    
    if result.count == 0 {
        let tempMemo = monthlyMemo()
        
        tempMemo.month = primaryKey
        tempMemo.text = text
        
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(tempMemo)
        }
        
    } else {
        
        let tempMemo = monthlyMemo()
        tempMemo.month = primaryKey
        tempMemo.text = text
        
        try! realm.write {
            realm.add(tempMemo, update: true)
        }
    }
}

func realmQueryMonthlyMemo  (date: NSDate) -> String? {
    let realm = try! Realm()
    let primaryKey = getPrimaryKeyMonthlyMemo(date: date)
    
    let result = realm.objects(monthlyMemo.self).filter("month = '\(primaryKey)'")
    
    if result.count == 0 {
        return "set monthly memo"
    } else {
        return result[0].text
    }
}

func deleteQueryMonthlyMemo (date: NSDate) {
    let realm = try! Realm()
    let primaryKey = getPrimaryKeyMonthlyMemo(date: date)
    
    let result = realm.objects(monthlyMemo.self).filter("month = '\(primaryKey)'")
    
    try! realm.write {
        realm.delete(result[0])
    }
}


func getPrimaryKeyMonthlyMemo (date: NSDate) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
    
    return formatter.string(from: date as Date)
}


func realmToArrayMonthlyMemo () -> [String] {
    var returnArray = [String]()
    let realm = try! Realm()
    let datas = realm.objects(monthlyMemo.self)
    
    for data in datas {
        returnArray.append("\(data.month) : \(data.text)")
    }
    
    return returnArray
}
