//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by Yohan Hyunsung Yi on 2017. 7. 30..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import UIKit
import JTAppleCalendar
import UserNotifications
import ModernSearchBar


class MainViewController: UIViewController {

    @IBOutlet weak var calendarCollectionView: JTAppleCalendarView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var monthYear: UILabel!

    @IBOutlet weak var calendarStacView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bodyStackView: UIStackView!
    @IBOutlet weak var masterStackView: UIStackView!
    @IBOutlet var masterView: UIView!
    @IBOutlet weak var holiday: UILabel!
    
    @IBOutlet weak var iconUp: UIStackView!
    @IBOutlet weak var toolBar: UIToolbar!

    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var deleteAlarmButton: UIButton!
    
    @IBOutlet weak var searchBar : ModernSearchBar!
    @IBOutlet weak var monthlyMemoButton: UIButton!
    
    var dateFormatter = DateFormatter()
    var aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    var picker = timePickerView()
    var sceduleNotofocation = dailyMemoNotificationCenter()
    var accessoryToolbar = KeyboardAccessoryToolbar()
    
    var todayString = String()
    var today = NSDate()
    var keyboardOnScreen = false
    var selectedDateData = NSDate()
    var dateNeedsToUpdat : Date?
    var displayMonth = NSDate()
    var alertText : UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()
        getToday()
        setupDatePicker()
        getAlarmsList()
        registerNotification()
        
        self.deleteAlarmButton.contentHorizontalAlignment = .left
        self.text.delegate = self
        
        //Font setup
        self.searchBar.searchLabel_font = UIFont(name: "Avenir-Light", size: 13)
        
        //Search Bar
        searchBar.isHidden = true
        self.makingSearchBarAwesome()
        self.configureSearchBar()
        
        //Calendar View: Go to Today
        calendarCollectionView.scrollToDate(today as Date)
        calendarCollectionView.selectDates([NSDate() as Date])
        
        calendarCollectionView.minimumLineSpacing = -1
        calendarCollectionView.minimumInteritemSpacing = -1
        
        subscribeToNotification(.UIKeyboardWillShow, selector: #selector(keyboardWillShow))
        subscribeToNotification(.UIKeyboardWillHide, selector: #selector(keyboardWillHide))
        subscribeToNotification(.UIKeyboardDidShow, selector: #selector(keyboardDidShow))
        subscribeToNotification(.UIKeyboardDidHide, selector: #selector(keyboardDidHide))
        
        //Assign KeyBoard Acc View
        self.text.inputAccessoryView = accessoryToolbar
        accessoryToolbar.currentView = self.text
        accessoryToolbar.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        //get date from Dissmissed Alarm View Controller
        if let date = self.aplicationDelegate.dismissCheck {
            calendarCollectionView.scrollToDate(date as Date)
            calendarCollectionView.selectDates([date as Date])
            self.aplicationDelegate.dismissCheck = nil
        }
        
        calendarCollectionView.reloadData()
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
    
    func getAlarmsList() {
        self.aplicationDelegate.alarmList.removeAll()
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            for request in requests{
                let alarm = alarmList(identifier: request.identifier, title: request.content.title, text: request.content.body)
                self.aplicationDelegate.alarmList.append(alarm)
            }
        })
    }
    
    func getToday() {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.timeZone = Calendar.current.timeZone
        todayString = dateFormatter.string(from: now as Date)
    }
    
}







