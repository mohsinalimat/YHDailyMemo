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
import ModernSearchBar


// MARK: Regarding KEYBOARD
extension MainViewController: ModernSearchBarDelegate {
    
    //----------------------------------------
    // OPTIONNAL DELEGATE METHODS
    //----------------------------------------
    
    ///Called if you use String suggestion list
    func onClickItemSuggestionsView(item: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let dateArray = item.components(separatedBy: " ")
        let dateData = "\(dateArray[1]) \(dateArray[2]) \(dateArray[0])"
        let dateNSdate = dateFormatter.date(from: dateData)
        
        print(dateFormatter.string(from: dateNSdate!))
        
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        self.calendarCollectionView.scrollToDate(dateNSdate!)
        self.calendarCollectionView.selectDates([dateNSdate!])

    }
    
    ///Called when user touched shadowView
    func onClickShadowView(shadowView: UIView) {
        searchBar.resignFirstResponder()
        self.searchBar.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("Text did change, what i'm suppose to do ?")
        //self.searchBar.endEditing(true)
    }
    
    func configureSearchBar(){
        ///Create array of string
        let dbList = realmToArray()
        
        ///Adding delegate
        self.searchBar.delegateModernSearchBar = self
        
        ///Set datas to search bar
        self.searchBar.setDatas(datas: dbList)
        
        ///Custom design with all paramaters if you want to
        self.customDesign()
    }
    
    
    //----------------------------------------
    // CUSTOM DESIGN (WITH ALL OPTIONS)
    //----------------------------------------
    
    func customDesign(){
        
        // --------------------------
        // Enjoy this beautiful customizations (It's a joke...)
        // --------------------------
        
        
        //Modify shadows alpha
        self.searchBar.shadowView_alpha = 0.8
        
        self.searchBar.searchLabel_font = UIFont(name: "Avenir-Light", size: 13)
        self.searchBar.searchLabel_textColor = UIColor.darkGray
        
        ///Modify properties of the suggestionsView
        self.searchBar.suggestionsView_backgroundColor = UIColor.lightGray
        self.searchBar.suggestionsView_contentViewColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 0.3)
        self.searchBar.suggestionsView_separatorStyle = .singleLine
        self.searchBar.suggestionsView_selectionStyle = UITableViewCellSelectionStyle.default
        self.searchBar.suggestionsView_verticalSpaceWithSearchBar = 3
        self.searchBar.suggestionsView_spaceWithKeyboard = 20
        self.searchBar.suggestionsView_maxHeight = 500
    }
    
    func makingSearchBarAwesome(){
        self.searchBar.layer.borderWidth = 0
        self.searchBar.layer.borderColor = UIColor.white.cgColor
    }
    

    @IBAction func search(_ sender: Any) {
        if searchBar.isHidden {
            searchBar.isHidden = false
            self.searchBar.setDatas(datas: realmToArray())
        } else {
            searchBar.isHidden = true
        }
    }
    
    
}
