//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by Yohan Hyunsung Yi on 2017. 7. 30..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class MainViewController: UIViewController {

    @IBOutlet weak var calendarCollectionView: JTAppleCalendarView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var monthYear: UILabel!
    
    var todayString = String()
    var today = NSDate()
    
    func getToday(){
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.locale = Calendar.current.locale
        todayString = dateFormatter.string(from: now as Date)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        getToday()
        goToToday((Any).self)
    }
    
    func setupCalendarView() {
        //SET UP Line Spacing
        calendarCollectionView.minimumLineSpacing = 0
        calendarCollectionView.minimumInteritemSpacing = 0
        
        //SEt UP first View
        calendarCollectionView.visibleDates{ visibleDates in
            self.setupViewOfCalendar(from: visibleDates)
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CalendarCustomCell else { return }
    
        if cellState.dateBelongsTo == .thisMonth{
            validCell.dateLabel.textColor = UIColor.darkGray
        } else {
            validCell.dateLabel.textColor = UIColor.lightGray
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CalendarCustomCell else { return }
        
        func todayCheck(){
            //MARK: Today Check
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM dd"
            if formatter.string(from: cellState.date) == todayString {
                validCell.selectedCell.isHidden = false
                validCell.selectedCell.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 0.4)
            }
        }
        
        if validCell.isSelected{
            validCell.selectedCell.isHidden = false
            validCell.selectedCell.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        } else {
            validCell.selectedCell.isHidden = true
            todayCheck()
        }
    }
    
    func setupViewOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM YYYY"
        self.monthYear.text = formatter.string(from: date)
    }
    
    @IBAction func goToToday(_ sender: Any) {
        calendarCollectionView.scrollToDate(today as Date)
        calendarCollectionView.selectDates([NSDate() as Date])
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
    
        formatter.dateFormat = "MMMM YYYY"
        monthYear.text = formatter.string(from: date)
    }
}
