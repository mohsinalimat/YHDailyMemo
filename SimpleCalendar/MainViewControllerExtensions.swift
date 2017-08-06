//
//  MainViewControllerExtensions.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 6..
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

extension MainViewController: JTAppleCalendarViewDelegate {
    //MARK: Calendar Start & End
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2200 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate,endDate: endDate)
        return parameters
    }
}


extension MainViewController: JTAppleCalendarViewDataSource {
    
    //MARK: Display Cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCustomCell
        cell.dateLabel.text = cellState.text
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        return cell
    }
    
    //MARK: Did Selected Cell
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        text.text = String(describing: date)
    }
    
    //MARK: Did DeSelected Cell
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    //MARK: Disolay current Month and Year
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM / YYYY"
        monthYear.text = formatter.string(from: date)
    }
}
