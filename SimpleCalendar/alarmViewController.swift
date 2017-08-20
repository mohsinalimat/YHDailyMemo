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
    
    let notificationCenter: UNUserNotificationCenter = {
        return UNUserNotificationCenter.current()
    }()
    
    var numberOfRow = 0
    var alarms:[String] = []
    var detail:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlarmsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //getAlarmsList()
        //tableView.reloadData()
    }
    
    func getAlarmsList() {
        notificationCenter.getPendingNotificationRequests(completionHandler: {requests -> () in
            self.numberOfRow = requests.count
            for request in requests{
                self.alarms.append(request.content.title)
                self.detail.append(request.content.body)
                print(request.content.title)
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")!
        cell.textLabel?.text = self.alarms[indexPath.row]
        cell.detailTextLabel?.text = self.detail[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
}
