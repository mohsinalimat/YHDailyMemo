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
    let primaryKey = getPrimaryKey(date: date)
    
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
    let primaryKey = getPrimaryKey(date: date)
    
    let result = realm.objects(dailyMemo.self).filter("createdDate = '\(primaryKey)'")
    
    if result.count == 0 {
        return nil
    } else {
        return result[0]
    }
}

func deleteQuery(date: NSDate) {
    let realm = try! Realm()
    let primaryKey = getPrimaryKey(date: date)
    
    let result = realm.objects(dailyMemo.self).filter("createdDate = '\(primaryKey)'")
    
    try! realm.write {
        realm.delete(result[0])
    }
}

func previewQuery(date: NSDate) -> String {
    let realm = try! Realm()
    let primaryKey = getPrimaryKey(date: date)

    let result = realm.objects(dailyMemo.self).filter("createdDate = '\(primaryKey)'")
    
    if result.count == 0 {
        return ""
    } else {
        return result[0].text.truncate(length: 5, trailing: "..")
    }
}


func getPrimaryKey (date: NSDate) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MM dd"
    
    return formatter.string(from: date as Date)
}


extension String {
    /**
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     
     - Parameter length: A `String`.
     - Parameter trailing: A `String` that will be appended after the truncation.
     
     - Returns: A `String` object.
     */
    func truncate(length: Int, trailing: String = ".") -> String {
        if self.characters.count > length {
            return String(self.characters.prefix(length)) + trailing
        } else {
            return self
        }
    }
}


func realmToArray () -> [String] {
    var returnArray = [String]()
    let realm = try! Realm()
    let datas = realm.objects(dailyMemo.self)

    for data in datas {
        returnArray.append("\(data.createdDate) : \(data.text)")
    }

    return returnArray
}




