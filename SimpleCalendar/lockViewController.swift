//
//  lockViewController.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 27..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import UIKit
import SmileLock

class PasswordLoginViewController: UIViewController {
    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    //MARK: Property
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create PasswordContainerView
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        passwordContainerView.deleteButtonLocalizedTitle = "delete"
        
        //customize password UI
        passwordContainerView.tintColor = UIColor.color(.textColor)
        passwordContainerView.highlightedColor = UIColor.color(.blue)
    }
}

extension PasswordLoginViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension PasswordLoginViewController {
    func validation(_ input: String) -> Bool {
        return input == passwordRealmQuery()
    }
    
    func validationSuccess() {
        print("success!")
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        loginVC?.modalTransitionStyle = .crossDissolve
        self.present(loginVC!, animated: true, completion: nil)
    }
    
    func validationFail() {
        print("failure!")
        passwordContainerView.wrongPassword()
    }
}
