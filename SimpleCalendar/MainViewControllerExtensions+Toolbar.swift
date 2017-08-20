//
//  MainViewControllerExtension+.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 9..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar
import UserNotifications


//MARK: ToolBar Items
extension MainViewController {
    
    
    //MARK: Previous Memo
    @IBAction func previousMemo(_ sender: Any) {
        for i in 1...365 {
            let date = selectedDateData.addDays(days: -i)
            
            if realmQuery(date: date as NSDate) != nil{
                calendarCollectionView.scrollToDate(date as Date)
                calendarCollectionView.selectDates([date as Date as Date])
                print(date)
                break
            }
        }
    }
    
    
    //MARK: Goto Today
    @IBAction func goToToday(_ sender: Any) {
        calendarCollectionView.scrollToDate(today as Date)
        calendarCollectionView.selectDates([NSDate() as Date])
    }
    

    
    //MARK: Set up the Alarm
    @IBAction func setUpAlarm(_ sender: Any) {
        picker.show(inVC: self)
    }
    
    
    
    //MARK: Delete Memo
    @IBAction func deleteMemo(_ sender: Any) {
        
        //MARK: Alret to delete
        if self.text.text != "" {
                let alertController = UIAlertController(title: "ARE YOU SURE?", message: "Your history will be gone...", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "DELETE", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            
                deleteQuery(date: self.selectedDateData)
                self.text.text = ""
                self.calendarCollectionView.reloadData()
            }))
        
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: Next Memo
    @IBAction func nextMemo(_ sender: Any) {
        
        for i in 1...365 {
            let date = selectedDateData.addDays(days: i)

            if realmQuery(date: date as NSDate) != nil{
                calendarCollectionView.scrollToDate(date as Date)
                calendarCollectionView.selectDates([date as Date as Date])
                print(date)
                break
            }
        }
    }
}

extension NSDate {
    func addDays(days:Int) -> NSDate{
        let newDate = Calendar.current.date(
            byAdding: .day,
            value: days,
            to: self as Date
        )
        return newDate! as NSDate
    }
}




