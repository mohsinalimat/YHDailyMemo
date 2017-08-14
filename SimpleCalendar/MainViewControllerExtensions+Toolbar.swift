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
    }
    
    //MARK: Delete Memo
    @IBAction func deleteMemo(_ sender: Any) {
        self.text.text = ""
        deleteQuery(date: selectedDateData)
        calendarCollectionView.reloadData()
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

