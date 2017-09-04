//
//  alarmViewController.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 20..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class AlarmViewController: UITableViewController {
    
    var aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    let notificationCenter: UNUserNotificationCenter = {
        return UNUserNotificationCenter.current()
    }()
    
    var numberOfRow = 0
    var alarms:[alarmList] = []
    var controlNotification = dailyMemoNotificationCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAlarmListFromAppDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func getAlarmListFromAppDelegate() {
        alarms = self.aplicationDelegate.alarmList
        numberOfRow = alarms.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")!

        cell.textLabel?.text = self.alarms[indexPath.row].title
        cell.detailTextLabel?.text = self.alarms[indexPath.row].text
        cell.imageView?.image = UIImage(named: "Calendar.png")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            let alertController = UIAlertController(title: "Delete Alarm", message: "Are You Sure?", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                
                self.controlNotification.cancelNotification(identifier: self.alarms[indexPath.row].identifier)
                self.alarms.remove(at: indexPath.row)
                
                if self.numberOfRow == 1 {
                    self.numberOfRow = 0
                }else {
                    self.numberOfRow = self.numberOfRow - 1
                }
                
                self.tableView.deleteRows(at: [indexPath], with: .left)

            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
            
            let pickedDate = "\(self.alarms[indexPath.row].identifier) 12:00:00+0000"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss+0000"
            let date = dateFormatter.date(from:pickedDate)!
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
            let finalDate = calendar.date(from:components)
            
            self.aplicationDelegate.dismissCheck = finalDate
            self.dismiss(animated: true, completion: {})
        }
        
        editAction.backgroundColor = UIColor.lightGray
        return [deleteAction, editAction]
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }

}
