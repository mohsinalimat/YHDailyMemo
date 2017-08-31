//
//  holidayViewController.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 30..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

class HolidayViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerDataSource = ["-Select-", "America", "Korea", "Not Select"]
    var aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.dataSource = self
        self.picker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 1 {
            settingRealmUpdate(lock: self.aplicationDelegate.lock, password: self.aplicationDelegate.password, holiday: "AMERICA", luna: self.aplicationDelegate.lunarCalendar)
        } else if row == 2 {
            settingRealmUpdate(lock: self.aplicationDelegate.lock, password: self.aplicationDelegate.password, holiday: "KOREA", luna: self.aplicationDelegate.lunarCalendar)
        } else if row == 3 {
            settingRealmUpdate(lock: self.aplicationDelegate.lock, password: self.aplicationDelegate.password, holiday: "", luna: self.aplicationDelegate.lunarCalendar)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
}
