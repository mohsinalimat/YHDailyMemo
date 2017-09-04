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

// MARK: Regarding Monthly Memo
extension MainViewController {
    
    //Edit Monthly Memo
    @IBAction func monthlyMemoAction(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: self.displayMonth as Date)
        
        let alert = UIAlertController(title: "\(month)", message: "Set Monthly Memo", preferredStyle: .alert)
        
        //Alaer View Text Field Set up
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
        
        //Delete
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [] (_) in
            if self.monthlyMemoButton.titleLabel?.text != "set monthly memo" {
                deleteQueryMonthlyMemo(date: self.displayMonth)
            }
            self.monthlyMemoButton.setTitle("set monthly memo", for: .normal)
        }))
        
        //Set up New Monthly Memo
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
    
    //Monthly Memo - Save to Realm
    func setMonthlyButtonTitle (date: Date) -> String {
        return realmQueryMonthlyMemo(date: date as NSDate)!
    }
}




