//
//  MyPasswordUIValidation.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 27..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import UIKit
import SmileLock

class MyPasswordModel {
    class func match(_ password: String) -> MyPasswordModel? {
        guard password == "123456" else { return nil }
        return MyPasswordModel()
    }
}

class MyPasswordUIValidation: PasswordUIValidation<MyPasswordModel> {
    init(in stackView: UIStackView) {
        super.init(in: stackView, digit: 6)
        validation = { password in
            MyPasswordModel.match(password)
        }
    }
    
    //handle Touch ID
    override func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            let dummyModel = MyPasswordModel()
            self.success?(dummyModel)
        } else {
            passwordContainerView.clearInput()
        }
    }
}


enum ColorType: String {
    case blue = "20aee5"
    case textColor = "555555"
}

extension UIColor {
    
    class func hexStr(_ hexStr: String) -> UIColor {
        return UIColor.hexStr(hexStr, alpha: 1)
    }
    
    class func color(_ hexColor: ColorType) -> UIColor {
        return UIColor.hexStr(hexColor.rawValue, alpha: 1.0)
    }
    
    class func hexStr(_ str: String, alpha: CGFloat) -> UIColor {
        let hexStr = str.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b , alpha: alpha)
        } else {
            print("Invalid hex string")
            return .white
        }
    }
    
}
