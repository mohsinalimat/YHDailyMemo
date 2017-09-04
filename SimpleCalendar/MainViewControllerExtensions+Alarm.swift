//
//  11.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 19..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar
import UserNotifications

//Extension for Alarm
extension MainViewController: GMDatePickerDelegate {
    
    func gmDatePicker(_ gmDatePicker: GMDatePicker, didSelect date: Date){
        
        if Calendar(identifier: .gregorian).isDate(Date(), inSameDayAs: self.selectedDateData as Date) && (date.description < Date().description) {
            
            let pastAlarm = UIAlertController(title: "Selected Past Time", message: "Please Select Future Time", preferredStyle: UIAlertControllerStyle.alert)
            pastAlarm.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(pastAlarm, animated: true, completion: nil)
        } else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = Calendar.current.timeZone
            formatter.locale = Calendar.current.locale
            self.deleteAlarmButton.setTitle("\(formatter.string(from: date)) ✕", for: .normal)
            sceduleNotofocation.setUpNotification(selectedTime: date, selectedDate: self.selectedDateData as Date, text: self.text.text)
            
            let pastAlarm = UIAlertController(title: "Alarm Has Been Set Up", message: "", preferredStyle: UIAlertControllerStyle.alert)
            pastAlarm.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(pastAlarm, animated: true, completion: nil)
        }
        
    }
    
    func gmDatePickerDidCancelSelection(_ gmDatePicker: GMDatePicker) {
        
    }
    
    func setupDatePicker() {
        
        picker.delegate = self
        
        picker.config.startDate = Date()
        
        picker.config.animationDuration = 0.5
        
        picker.config.cancelButtonTitle = "Cancel"
        picker.config.confirmButtonTitle = "Confirm"
        
        picker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        picker.config.headerBackgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        picker.config.confirmButtonColor = UIColor.black
        picker.config.cancelButtonColor = UIColor.black
        
    }
    
    @IBAction func deleteAlarm(_ sender: Any) {
        let controlNotification = dailyMemoNotificationCenter()
        
        if self.deleteAlarmButton.titleLabel?.text == "SET ALARM" {
            
            picker.show(inVC: self)
            
        } else {
            let alertController = UIAlertController(title: "Daily Alarm", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Change", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                
                controlNotification.cancelNotification(identifier: self.selectedDate.text!)
                self.picker.show(inVC: self)
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { (action: UIAlertAction!) in
                
                let deleteController = UIAlertController(title: "Delete Alarm", message: "Are You Sure?", preferredStyle: UIAlertControllerStyle.alert)
                deleteController.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { (action: UIAlertAction!) in
                    controlNotification.cancelNotification(identifier: self.selectedDate.text!)
                    self.deleteAlarmButton.setTitle("SET ALARM", for: .normal)
                }))
                deleteController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(deleteController, animated: true, completion: nil)
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)

        }
        


    }
}


//Set Up Local Notification
extension MainViewController {
    
    func registerNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (success, error) in
            if success {
                print("Register success")
            } else {
                print("Register error")
            }
        }
    }
    
    
    
    
    
}
