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
        let month = formatter.string(from: self.selectedDateData as Date)
        
        let alert = UIAlertController(title: "\(month)", message: "Set Monthly Memo", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            if let defaultText = realmQueryMonthlyMemo(date: self.selectedDateData){
                textField.text = defaultText
            }
            
            if ((textField.text!.characters.count) > 20) {
                textField.deleteBackward()
            }
            
            textField.font = UIFont(name: "Avenir-Light", size: 13)
            
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [alert] (_) in
            let textField = alert.textFields![0]
            realmUpdateMonthlyMemo(date: self.selectedDateData, text: (textField.text)!)
            self.monthlyMemoButton.setTitle((textField.text)!, for: .normal)
        }))
        
        alert.addAction(UIAlertAction(title: "DELETE", style: .destructive, handler: { [] (_) in
            deleteQueryMonthlyMemo(date: self.selectedDateData)
            self.monthlyMemoButton.setTitle("set monthly memo", for: .normal)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func setMonthlyButtonTitle (date: Date) -> String {
        return realmQueryMonthlyMemo(date: date as NSDate)!
    }
}




