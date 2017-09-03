//
//  mainViewControllerExtensions+MonthlyMemo.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 29..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension MainViewController {
    
    @IBAction func monthlyMemoAction(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: self.displayMonth as Date)
        
        let alert = UIAlertController(title: "\(month)", message: "Set Monthly Memo", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
           
            self.alertText = textField
            self.alertText.delegate = self
            
            if let defaultText = realmQueryMonthlyMemo(date: self.displayMonth){
                if defaultText == "set monthly memo" {
                     self.alertText.text = ""
                } else {
                     self.alertText.text = defaultText
                }
            }
        }
        
        alert.addAction(UIAlertAction(title: "DELETE", style: .destructive, handler: { [] (_) in
            if self.monthlyMemoButton.titleLabel?.text != "set monthly memo" {
                deleteQueryMonthlyMemo(date: self.displayMonth)
            }
            self.monthlyMemoButton.setTitle("set monthly memo", for: .normal)
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [alert] (_) in
            
            let textField = alert.textFields![0]
            if textField.text == "" {
                self.monthlyMemoButton.setTitle("set monthly memo", for: .normal)
            } else {
                realmUpdateMonthlyMemo(date: self.displayMonth, text: (textField.text)!)
                self.monthlyMemoButton.setTitle((textField.text)!, for: .normal)
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func setMonthlyButtonTitle (date: Date) -> String {
        return realmQueryMonthlyMemo(date: date as NSDate)!
    }
}




