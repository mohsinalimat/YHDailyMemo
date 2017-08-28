//
//  setUpAlarm.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 19..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class dailyMemoNotificationCenter {

    var aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    let notificationCenter: UNUserNotificationCenter = {
        return UNUserNotificationCenter.current()
    }()
    
    func setUpNotification( selectedTime: Date, selectedDate: Date, text: String) {
        
        let gregorianCalendar = Calendar(identifier: .gregorian)
        var componentsTime = gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedTime)
        var componentsDate = gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss+0000"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
   
        let mergedDate = "\(String(describing: componentsDate.year!))-\(String(describing: componentsDate.month!))-\(String(describing: componentsDate.day!)) \(String(describing: componentsTime.hour!)):\(String(describing: componentsTime.minute!)):00+0000"
        
        let date = dateFormatter.date(from:mergedDate)!
        var calendar = Calendar.current
        calendar.timeZone = Calendar.current.timeZone
        calendar.locale = Calendar.current.locale
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .calendar], from: date)

        setNotification(dateComponont: components, text: text)
    }
    
    
    func setNotification(dateComponont: DateComponents, text: String) {
        
        let finalSetUpDateAndTime = Calendar.current.date(from:dateComponont)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YY"
        let notificationIdenifier = formatter.string(from: finalSetUpDateAndTime!)

        formatter.dateFormat = "MM/dd/YYYY HH:mm"
        let title = formatter.string(from: finalSetUpDateAndTime!)
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponont, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = UNNotificationSound.default()
        
        let alarm = alarmList(identifier: notificationIdenifier, title: title, text: text)
        aplicationDelegate.alarmList.append(alarm)
        
        let request = UNNotificationRequest(identifier: notificationIdenifier, content: content, trigger: calendarTrigger)
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("failed with error: \(error)")
            } else {
                print("notification scheduled: \(notificationIdenifier), \(calendarTrigger)")
            }
        })
    }
    
    func cancelNotification( identifier: String ) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        if let index:Int = aplicationDelegate.alarmList.index(where: {$0.identifier == identifier}) {
            aplicationDelegate.alarmList.remove(at: index)
        }
    }

}

        
