//
//  setupPasswordViewController.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 30..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit
import PinCodeTextField

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var pinCodeTextField: PinCodeTextField!
    var aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pinCodeTextField.becomeFirstResponder()
        pinCodeTextField.delegate = self
        pinCodeTextField.keyboardType = .numberPad
    }
    
    override public var prefersStatusBarHidden: Bool {
        return false
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}


extension PasswordViewController: PinCodeTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
        
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        settingRealmUpdate (lock: self.aplicationDelegate.lock, password: textField.text, holiday: self.aplicationDelegate.holiday, luna: self.aplicationDelegate.lunarCalendar)
        
        self.dismiss(animated: true, completion: nil)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        return true
    }
}

