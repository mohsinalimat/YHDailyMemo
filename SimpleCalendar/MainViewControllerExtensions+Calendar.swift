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
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 generateOutDates: .tillEndOfRow)
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
        
        self.searchBar.isHidden = true
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let displaiedSelectedDate = formatter.string(from: date)
        var displayHolidayandLunadate = " "
        var displayLunaday = " "
        
        self.selectedDateData = date as NSDate
        
        
        //Check Having Alram
        if checkSelectedDateIsBeforeThanToday(self.selectedDateData as Date) {
            self.deleteAlarmButton.isEnabled = true
            self.deleteAlarmButton.setTitle("SET ALARM",for: .normal)
            for temp in self.aplicationDelegate.alarmList{
                if temp.identifier == displaiedSelectedDate {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    formatter.timeZone = Calendar.current.timeZone
                    formatter.locale = Calendar.current.locale
                    
                    self.deleteAlarmButton.setTitle("\(temp.date) ✕",for: .normal)
                    break
                }
            }

        } else {
            self.deleteAlarmButton.setTitle("",for: .normal)
            self.deleteAlarmButton.isEnabled = false
        }
        
        
        //LUNA CALENDAR ON
        if self.aplicationDelegate.lunarCalendar! {
        
            //Get Lunaday
            if let tempLunaday = lunaDate(Soldate: self.selectedDateData) {
                if tempLunaday == "0000/" {
                    displayLunaday = " "
                } else {
                    displayLunaday = tempLunaday
                }
            }
        
            //Get Holiday
            if let displayHoliday = getHoliday(date: self.selectedDateData) {
                displayHolidayandLunadate = "\(displayHoliday)"
            } else {
                displayHolidayandLunadate = "\(displayLunaday)"
            }
            
        //LUNA CALENDAR OFF
        } else {
            //Get Holiday
            if let displayHoliday = getHoliday(date: self.selectedDateData) {
                displayHolidayandLunadate = "\(displayHoliday)"
            }
        }
        
        self.holiday.text = displayHolidayandLunadate
        selectedDate.text = displaiedSelectedDate
        
        //MARK: realm Query
        if let data = realmQuery(date: selectedDateData){
            self.text.text = data.text
        } else {
            //MARK: no data
            self.text.text = ""
        }
        
    }
    
    //MARK: Did DeSelected Cell
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    //MARK: Display current Month and Year
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        self.displayMonth = date as NSDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM / YYYY"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        monthYear.text = formatter.string(from: date)
        
        //MARK: Set Monthly Memo
        self.monthlyMemoButton.setTitle(setMonthlyButtonTitle(date: date),for: .normal)
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CalendarCustomCell else { return }
        
        //Selected Month
        if cellState.dateBelongsTo == .thisMonth{
            validCell.dateLabel.textColor = UIColor.darkGray
        } else {
            validCell.dateLabel.textColor = UIColor.lightGray
        }
        
        //Sunday
        if cellState.day == .sunday{
            validCell.dateLabel.textColor = UIColor(red: 255/255.0, green: 32/255.0, blue: 0/255.0, alpha: 0.6)
        }
        
        //Holiday
        if let _ = getHoliday(date: cellState.date as NSDate) {
            validCell.dateLabel.textColor = UIColor(red: 255/255.0, green: 32/255.0, blue: 0/255.0, alpha: 0.6)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        //Has Alarm
        for cell in aplicationDelegate.alarmList {
            if cell.identifier == formatter.string(from: cellState.date) {
                validCell.dateLabel.textColor = UIColor.hexStr("2873D2")
                break
            }
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CalendarCustomCell else { return }
        
        func todayCheck(){
            // Today Check
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM dd"
            formatter.locale = Calendar.current.locale
            formatter.timeZone = Calendar.current.timeZone
            
            if formatter.string(from: cellState.date) == todayString {
                validCell.selectedCell.isHidden = false
                validCell.selectedCell.backgroundColor = UIColor(red: 79/255.0, green: 179/255.0, blue: 156/255.0, alpha: 0.3)
            }
        }
        
        //Selected Day
        if validCell.isSelected {
            validCell.selectedCell.isHidden = false
            validCell.selectedCell.backgroundColor = UIColor(red: 79/255.0, green: 179/255.0, blue: 156/255.0, alpha: 0.7)
        } else {
            validCell.selectedCell.isHidden = true
            todayCheck()
        }
    }
    
    //Header Title : Month/Year
    func setupViewOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM YYYY"
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        
        self.monthYear.text = formatter.string(from: date)
    }

}
