//
//  keyboardAccView.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 7..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import UIKit

class KeyboardAccessoryToolbar: UIToolbar {
    fileprivate static let toolBarHeight: CGFloat = 44
    
    // MARK: - Initialization
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: KeyboardAccessoryToolbar.toolBarHeight))
        addBarItems()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBarItems()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Custom bar items
    func addBarItems() {
        
        let insertBarButton = UIBarButtonItem(image: UIImage(named: "weatehr_cloud.png"), style: UIBarButtonItemStyle(rawValue: 0)!, target: self, action: #selector(KeyboardAccessoryToolbar.insertBar))
        let insertDotButton = UIBarButtonItem(image: UIImage(named: "weatehr_cloud.png"), style: UIBarButtonItemStyle(rawValue: 0)!, target: self, action: #selector(KeyboardAccessoryToolbar.insertDot))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(KeyboardAccessoryToolbar.done))
        items = [insertBarButton,flexibleSpace, insertDotButton, flexibleSpace, doneBarButton]
    }
    
    func done() {
        // Pressing done asks delegate if textField should end editing
        // If delegate never implemented it, default to true
        // Simulate a return key press
        var shouldReturn = true
        if let textField = currentView as? UITextField {
            shouldReturn = textField.delegate?.textFieldShouldEndEditing?(textField) ?? shouldReturn
        } else if let textView = currentView as? UITextView {
            shouldReturn = textView.delegate?.textViewShouldEndEditing?(textView) ?? shouldReturn
        }
        
        if shouldReturn {
            print("shouldReturn")
            // If delegate allow currentView to end editing, then resign as first responder
            currentView?.resignFirstResponder()
        }
    }
    
    func insertBar() {
        if let textView = currentView as? UITextView {
            textView.insertText("\n")
            textView.insertText("------------------------")
            textView.insertText("\n")
        }
    }
    
    func insertDot() {
        if let textView = currentView as? UITextView {
            textView.insertText(" ∙ ")
        }
    }
    
    // MARK: - Current view relation
    weak var currentView: UIView? {
        didSet {
            if let textField = currentView as? UITextField {
                print("isTextField")
                textField.inputAccessoryView = self
            } else if let textView = currentView as? UITextView {
                print("isTextView")
                textView.inputAccessoryView = self
            }
        }
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}

