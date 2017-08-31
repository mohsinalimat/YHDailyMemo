//
//  setUpViewController.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 8. 27..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

protocol SwitchChangedDelegate {
    func changeStateTo(isOn: Bool, index: [Int:Int])
}

class setUpTableViewController: UITableViewController, SwitchChangedDelegate {

    
    @IBOutlet var setUpTableView: UITableView!
    var aplicationDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    let sections: [String] = ["Lock", "Calendar", "Memo", "Application"]
    let s1Data: [String] = ["App Lock", "Set Password"]
    let s2Data: [String] = ["Holiday", "Lunar Calendar"]
    let s3Data: [String] = ["Back Up", "Delete All"]
    let s4Data: [String] = ["App Store", "Info & Error Report"]
    
    var sectionData: [Int: [String]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView.delegate = self
        setUpTableView.dataSource = self
       
        setUpTableView.tableFooterView = UIView()
        setUpTableView.tableFooterView!.frame.size.height = tableView.frame.height - CGFloat(120) - CGFloat(384)
        setUpTableView.tableFooterView!.tintColor = UIColor.hexStr("ECECEC")
        setUpTableView.tableFooterView!.backgroundColor = UIColor.hexStr("ECECEC")
        
        sectionData = [0:s1Data, 1:s2Data, 2:s3Data, 3:s4Data]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return 2
            //(sectionData[section]?.count)!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setUpCell") as! setUpCell
            cell.delegate = self
            cell.indexRow = [ (indexPath.section) : (indexPath.row) ]
            
            cell.label.text = sectionData[indexPath.section]![indexPath.row]
            cell.label.font = UIFont(name: "Avenir-Light", size: 13)
            cell.label.textColor = UIColor.hexStr("69B1A4")
            cell.switcher.isHidden = true
            
            if indexPath == [0,0] {
                //App Lock
                cell.switcher.isHidden = false
                if aplicationDelegate.lock! {
                    cell.switcher.isOn = true
                } else {
                    cell.switcher.isOn = false
                }
                
            } else if indexPath == [0,1] {
                //Set Password
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
            } else if indexPath == [1,0] {
                //Holiday
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
            } else if indexPath == [1,1] {
                //Lunar Calendar
                cell.switcher.isHidden = false
                
                if aplicationDelegate.lunarCalendar! {
                    cell.switcher.isOn = true
                } else {
                    cell.switcher.isOn = false
                }
                
            } else if indexPath == [2,0] {
                //Back up
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
            } else if indexPath == [2,1] {
                //Delete All
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
            } else if indexPath == [3,0] {
                //App Store
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
            } else if indexPath == [3,1] {
                //Info
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
            }
            
            return cell
    }
    
    func changeStateTo(isOn: Bool, index: [Int:Int]) {
        // here update your dataModel
        print(isOn)
        print(index)
        
        if index == [0:0] {
            //App Lock
            if isOn {
                if aplicationDelegate.password! == "" {
                // Password is not set up
                    let alertController = UIAlertController(title: "SET UP PASSWORD", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                        
                        let passwordVC = self.storyboard?.instantiateViewController(withIdentifier: "passwordViewController")
                        passwordVC?.modalTransitionStyle = .crossDissolve
                        self.present(passwordVC!, animated: true, completion: nil)
                        
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                // Password is set up
                    settingRealmUpdate(lock: true, password: aplicationDelegate.password!, holiday: aplicationDelegate.holiday!, luna: aplicationDelegate.lunarCalendar!)
                }
            } else {
                settingRealmUpdate(lock: false, password: aplicationDelegate.password!, holiday: aplicationDelegate.holiday!, luna: aplicationDelegate.lunarCalendar!)
            }

            
        } else if index == [1:1]{
            //Lunar Calendar
            if isOn {
                settingRealmUpdate(lock: aplicationDelegate.lock!, password: aplicationDelegate.password!, holiday: aplicationDelegate.holiday!, luna: true)
            } else {
                settingRealmUpdate(lock: aplicationDelegate.lock!, password: aplicationDelegate.password!, holiday: aplicationDelegate.holiday!, luna: false)
            }
        }
        
    }
    
    
    //MARK: Header Setting
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.hexStr("ECECEC")
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 15, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Avenir-Heavy", size: 10)
        headerLabel.textColor = UIColor.lightGray
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected : \(indexPath)")
        
        if indexPath == [0,0] {
            //App Lock
            
        } else if indexPath == [0,1] {
            //Set Password
            
            if self.aplicationDelegate.password != "" {
                let alertController = UIAlertController(title: "CHANGE PASSWORD?", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "CHANGE", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                    
                    let passwordVC = self.storyboard?.instantiateViewController(withIdentifier: "passwordViewController")
                    passwordVC?.modalTransitionStyle = .crossDissolve
                    self.present(passwordVC!, animated: true, completion: nil)
                }))
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            } else {
                let passwordVC = self.storyboard?.instantiateViewController(withIdentifier: "passwordViewController")
                passwordVC?.modalTransitionStyle = .crossDissolve
                self.present(passwordVC!, animated: true, completion: nil)
            }
            
        } else if indexPath == [1,0] {
            //Holiday
            let holidayVC = self.storyboard?.instantiateViewController(withIdentifier: "holidayPickerViewController")
            holidayVC?.modalTransitionStyle = .crossDissolve
            self.present(holidayVC!, animated: true, completion: nil)
            
        } else if indexPath == [1,1] {
            //Lunar Calendar
            
        } else if indexPath == [2,0] {
            //Back up
            
        } else if indexPath == [2,1] {
            //Delete All
            
        } else if indexPath == [3,0] {
            //App Store
            
        } else if indexPath == [3,1] {
            //Info
            
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
}
