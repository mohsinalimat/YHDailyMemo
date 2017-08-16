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

    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bodyStackView: UIStackView!
    @IBOutlet weak var masterStackView: UIStackView!
    @IBOutlet var masterView: UIView!
    @IBOutlet weak var holiday: UILabel!
    
    @IBOutlet weak var iconUp: UIStackView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var selectedDate: UILabel!
    
    // Recycle toolbar for other text fields for less memory consumption
    lazy var accessoryToolbar = KeyboardAccessoryToolbar()
    
    var todayString = String()
    var today = NSDate()
    var keyboardOnScreen = false
    var selectedDateData = NSDate()
    let appSetUp = appSetting()
    
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
        
        //MARK:: Calendar View to Today
        calendarCollectionView.scrollToDate(today as Date)
        calendarCollectionView.selectDates([NSDate() as Date])
        
        subscribeToNotification(.UIKeyboardWillShow, selector: #selector(keyboardWillShow))
        subscribeToNotification(.UIKeyboardWillHide, selector: #selector(keyboardWillHide))
        subscribeToNotification(.UIKeyboardDidShow, selector: #selector(keyboardDidShow))
        subscribeToNotification(.UIKeyboardDidHide, selector: #selector(keyboardDidHide))
        
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
        
        if cellState.day == .sunday{
            validCell.dateLabel.textColor = UIColor(red: 255/255.0, green: 32/255.0, blue: 0/255.0, alpha: 0.6)
        }
        
        if let _ = getHoliday(date: cellState.date as NSDate) {
            validCell.dateLabel.textColor = UIColor(red: 255/255.0, green: 32/255.0, blue: 0/255.0, alpha: 0.6)

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
                validCell.selectedCell.backgroundColor = UIColor(red: 79/255.0, green: 179/255.0, blue: 156/255.0, alpha: 0.3)
            }
        }
        
        if validCell.isSelected{
            validCell.selectedCell.isHidden = false
            validCell.selectedCell.backgroundColor = UIColor(red: 79/255.0, green: 179/255.0, blue: 156/255.0, alpha: 0.7)
            
            
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
    

}







