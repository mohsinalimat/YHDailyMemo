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
extension MainViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //searchBar.resignFirstResponder()
        return true
    }


    // MARK: Show/Hide Keyboard
    func keyboardWillShow(_ notification: Notification) {
        if !keyboardOnScreen && text.isFirstResponder {
            
            topStackView.isHidden = true
            toolBar.isHidden = true

            // MARK: KeyBoard Acc View
            self.text.inputAccessoryView = accessoryToolbar
            accessoryToolbar.currentView = self.text
            
            self.view.frame.origin.y -= keyboardHeight(notification)

            iconUp.isHidden = false
        }
    }
    
    
    func keyboardWillHide(_ notification: Notification) {
        
        //MARK: Save textview to Realm
        if self.text.text != "" && text.isFirstResponder {
            realmUpdate(date: self.selectedDateData, text: self.text)
            calendarCollectionView.reloadData()
        }
        
        if keyboardOnScreen && text.isFirstResponder {
            topStackView.isHidden = false
            toolBar.isHidden = false
            self.view.frame.origin.y += keyboardHeight(notification)
            iconUp.isHidden = true
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
