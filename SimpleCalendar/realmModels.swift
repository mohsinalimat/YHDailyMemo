//
//  realmModels.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 13..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import RealmSwift


func realmUpdate( date: NSDate, text: UITextView ) {
    
    
    let realm = try! Realm()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MM dd"
    let primaryKey = formatter.string(from: date as Date)

    
    let result = realm.objects(dailyMemo.self).filter("createdDate = '\(primaryKey)'")
    
    if result.count == 0 {
        let tempMemo = dailyMemo()
        
        tempMemo.createdDate = primaryKey
        tempMemo.createdLocation = "LA"
        tempMemo.lunaDate = primaryKey
        tempMemo.text = text.text
        tempMemo.weather = "Rain"
        
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(tempMemo)
        }
        
    } else {
        
        let tempMemo = dailyMemo()
        
        tempMemo.createdDate = primaryKey
        tempMemo.createdLocation = "LA"
        tempMemo.lunaDate = primaryKey
        tempMemo.text = text.text
        tempMemo.weather = "Rain"
        
        try! realm.write {
            realm.add(tempMemo, update: true)
        }
    }
    
    print(Realm.Configuration.defaultConfiguration.fileURL!)
}

func realmQuery(date: NSDate) -> dailyMemo? {
    let realm = try! Realm()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MM dd"
    let primaryKey = formatter.string(from: date as Date)
    
    let result = realm.objects(dailyMemo.self).filter("createdDate = '\(primaryKey)'")
    
    if result.count == 0 {
        return nil
    } else {
        return result[0]
    }
}

func deleteQuery(date: NSDate) {
    let realm = try! Realm()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MM dd"
    
    let primaryKey = formatter.string(from: date as Date)
    
    let result = realm.objects(dailyMemo.self).filter("createdDate = '\(primaryKey)'")
    
    try! realm.write {
        realm.delete(result[0])
    }
}











