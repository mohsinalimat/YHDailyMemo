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
        var finalSetUpDateAndTime = Date()
        
        var componentsTime = gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedTime)
        var componentsDate = gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        var componentsFinal = gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: finalSetUpDateAndTime)
        
        // Change int value which you want to minus from current Date.
        componentsFinal.minute = componentsTime.minute
        componentsFinal.hour = componentsTime.hour
        componentsFinal.day = componentsDate.day
        componentsFinal.month = componentsDate.month
        componentsFinal.year = componentsDate.year
        componentsFinal.timeZone = TimeZone.current
        
        finalSetUpDateAndTime = gregorianCalendar.date(from: componentsFinal)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd YYYY HH mm"
        print(formatter.string(from: finalSetUpDateAndTime))
        
        print(finalSetUpDateAndTime)
        
        setNotification(notificationDate: finalSetUpDateAndTime, text: text)
    }
    
    
    func setNotification(notificationDate: Date, text: String) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YY"
        let notificationIdenifier = formatter.string(from: notificationDate)
        
        let titleFormatter = DateFormatter()
        titleFormatter.dateFormat = "MM/dd/YYYY HH:mm"
        let title = titleFormatter.string(from: notificationDate)
        
        var reminderDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: notificationDate)
        reminderDate.timeZone = TimeZone.current
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: reminderDate, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = UNNotificationSound.default()
        
        var alarm = alarmList()
        alarm.identifier = notificationIdenifier
        alarm.title = title
        alarm.text = text
        alarm.date = notificationDate
        
        aplicationDelegate.alarmList.append(alarm)
        
        let request = UNNotificationRequest(identifier: notificationIdenifier, content: content, trigger: calendarTrigger)
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("failed with error: \(error)")
            } else {
                print("notification scheduled")
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

        
