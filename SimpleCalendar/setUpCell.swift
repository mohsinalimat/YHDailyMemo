//
//  setUpCell.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 30..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

class setUpCell: UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    
    var delegate: SwitchChangedDelegate?
    var indexRow: [Int:Int]?
    
    @IBAction func switcherAction(_ sender: Any) {
        self.delegate?.changeStateTo(isOn: (sender as AnyObject).isOn, index: indexRow!)
    }
    
}
