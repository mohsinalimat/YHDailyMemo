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
    }
    
    //MARK: Next Memo
    @IBAction func nextMemo(_ sender: Any) {
    }
    
}

