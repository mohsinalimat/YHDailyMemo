//
//  lockRealmModel.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 30..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import RealmSwift

func settingRealmUpdate (lock: Bool?, password: String?, holiday: String?, luna: Bool?) {
    
    let aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    aplicationDelegate.lock = lock
    aplicationDelegate.password = password
    aplicationDelegate.holiday = holiday
    aplicationDelegate.lunarCalendar = luna
    
    /////
    let realm = try! Realm()
    let result = realm.objects(setting.self)
    let tempSetting = setting()

    tempSetting.setting = "setting"
    tempSetting.lock = lock!
    tempSetting.password = password!
    tempSetting.holiday = holiday!
    tempSetting.lunarCalendar = luna!
    
    if result.count == 0 {
        try! realm.write {
            realm.add(tempSetting)
        }
    } else {
        try! realm.write {
            realm.add(tempSetting, update: true)
        }
    }
}

func passwordRealmQuery  () -> String? {
    let realm = try! Realm()
    
    let result = realm.objects(setting.self)
    
    if result.count == 0 {
        return nil
    } else {
        return result[0].password
    }
}

func holidayRealmQuery  () -> String? {
    let realm = try! Realm()
    
    let result = realm.objects(setting.self)
    
    if result.count == 0 {
        return nil
    } else {
        return result[0].holiday
    }
}

func lunarRealmQuery  () -> Bool? {
    let realm = try! Realm()
    
    let result = realm.objects(setting.self)
    
    if result.count == 0 {
        return nil
    } else {
        return result[0].lunarCalendar
    }
}

func lockRealmQuery  () -> Bool? {
    let realm = try! Realm()
    
    let result = realm.objects(setting.self)
    
    if result.count == 0 {
        return nil
    } else {
        return result[0].lock
    }
}
