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
        print("User touched this item: "+item)
    }
    
    ///Called when user touched shadowView
    func onClickShadowView(shadowView: UIView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("Text did change, what i'm suppose to do ?")
    }
    
    //----------------------------------------
    // CONFIGURE SEARCH BAR (TWO WAYS)
    //----------------------------------------
    
    // 1 - Configure search bar with a simple list of string
    
    func configureSearchBar(){
        
        ///Create array of string
        var suggestionList = Array<String>()
        suggestionList.append("Onions")
        suggestionList.append("Celery")
        suggestionList.append("Very long vegetable to show you that cell is updated and fit all the row")
        suggestionList.append("Potatoes")
        suggestionList.append("Carrots")
        suggestionList.append("Broccoli")
        suggestionList.append("Asparagus")
        suggestionList.append("Apples")
        suggestionList.append("Berries")
        suggestionList.append("Kiwis")
        suggestionList.append("Raymond")
        
        ///Adding delegate
        self.searchBar.delegateModernSearchBar = self
        
        ///Set datas to search bar
        self.searchBar.setDatas(datas: suggestionList)
        
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
        self.searchBar.suggestionsView_backgroundColor = UIColor.brown
        self.searchBar.suggestionsView_contentViewColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 0.3)
        self.searchBar.suggestionsView_separatorStyle = .singleLine
        self.searchBar.suggestionsView_selectionStyle = UITableViewCellSelectionStyle.default
        self.searchBar.suggestionsView_verticalSpaceWithSearchBar = 3
        self.searchBar.suggestionsView_spaceWithKeyboard = 20
    }
    
    func makingSearchBarAwesome(){
        self.searchBar.layer.borderWidth = 0
        self.searchBar.layer.borderColor = UIColor.white.cgColor
    }
    

    @IBAction func search(_ sender: Any) {
        if searchBar.isHidden {
            searchBar.isHidden = false
        } else {
            searchBar.isHidden = true
        }
    }
    
    
}
