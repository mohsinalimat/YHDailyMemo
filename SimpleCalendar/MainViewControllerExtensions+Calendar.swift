//
//  MainViewContollerExtension+Calendar.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 9..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar


//MARK: Calendar Cell & Data Source

extension MainViewController: JTAppleCalendarViewDelegate {
    //MARK: Calendar Start & End
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2047 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate,endDate: endDate)
        return parameters
    }
}

extension MainViewController: JTAppleCalendarViewDataSource {
    
    //MARK: Display Cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCustomCell
        cell.dateLabel.text = cellState.text
        cell.previewCell.text = previewQuery(date: date as NSDate)
            
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        return cell
    }
    
    //MARK: Did Selected Cell
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let displaiedSelectedDate = formatter.string(from: date)
        var displayHolidayandLunadate = " "
        
        self.selectedDateData = date as NSDate
        
        
        //if appSetting.lunacalendar {
        
            //Get Lunaday
            let displayLunaday = lunaDate(Soldate: self.selectedDateData)
        
            //Get Holiday
            if let displayHoliday = getHoliday(date: self.selectedDateData) {
                displayHolidayandLunadate = "\(displayHoliday) | \(displayLunaday)"
            } else {
                displayHolidayandLunadate = "\(displayLunaday)"
            }
        
        //} else {
            //Holiday
        
        //}
        
        self.holiday.text = displayHolidayandLunadate
        
        selectedDate.text = displaiedSelectedDate
        
        //MARK: realm Query
        if let data = realmQuery(date: selectedDateData){
            self.text.text = data.text
            //self.weather
            //lunaDateHoliday.text = formatter.string(from: date)
        } else {
            //MARK: no data
            self.text.text = ""
            //self.weather = ""
            //lunaDateHoliday.text
        }
    
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
