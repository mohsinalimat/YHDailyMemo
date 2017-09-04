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
import RealmSwift



// MARK: Regarding KEYBOARD
extension MainViewController: UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: Show/Hide Keyboard
    func keyboardWillShow(_ notification: Notification) {
        if !keyboardOnScreen && text.isFirstResponder {
            
            self.searchBar.isHidden = true
            topStackView.isHidden = true
            toolBar.isHidden = true
            
            self.view.frame.origin.y -= keyboardHeight(notification)

            iconUp.isHidden = false
            deleteAlarmButton.isEnabled = false
            
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        //Block searchbar to textview
        if textView == self.text && searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
            return false
        }
        return true
    }
        
    
    func keyboardWillHide(_ notification: Notification) {
        
        //MARK: Save textview to Realm
        if self.text.text != "" && text.isFirstResponder {
            realmUpdate(date: self.selectedDateData, text: self.text)
            calendarCollectionView.reloadData()
        }
        
        //MARK: textview editing mode
        if keyboardOnScreen && text.isFirstResponder {
            topStackView.isHidden = false
            toolBar.isHidden = false
            self.view.frame.origin.y += keyboardHeight(notification)
            iconUp.isHidden = true
            deleteAlarmButton.isEnabled = true
            calendarCollectionView.scrollToDate(self.selectedDateData as Date)
        }
    }
    
    func keyboardDidShow(_ notification: Notification) {
        keyboardOnScreen = true
    }
    
    func keyboardDidHide(_ notification: Notification) {
        keyboardOnScreen = false
    }
    
    private func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        text.resignFirstResponder()
        searchBar.resignFirstResponder()
    }
    
    //MARK: Search Bar Text length limit
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (self.alertText.text?.characters.count)! >= 21 && range.length == 0 {
            return false
        }
        return true
    }
    
    //MARK: Dissmiss Keyboard
    @IBAction func iconUp(_ sender: Any) {
        text.resignFirstResponder()
    }
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
