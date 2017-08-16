//
//  lunaDateModel.swift
//  SimpleCalendar
//
//  Created by Yohan Yi on 2017. 8. 14..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import SWXMLHash
import UIKit

func lunaDate( Soldate: NSDate)-> String {
    
    var returnLunaDate = " "
    var solDay = ""
    var solMonth = ""
    
    //MARK: IF Date is stored, return date
    
    
    
    
    
    //MARK: Else - parshing from API
    if Calendar.current.component(.day, from: Soldate as Date) < 10{
        solDay = "0" + String(Calendar.current.component(.day, from: Soldate as Date))
    } else {
        solDay = String(Calendar.current.component(.day, from: Soldate as Date))
    }
    
    if Calendar.current.component(.month, from: Soldate as Date) < 10{
        solMonth = "0" + String(Calendar.current.component(.month, from: Soldate as Date))
    } else {
        solMonth = String(Calendar.current.component(.month, from: Soldate as Date))
    }
    
    let solYear = String(Calendar.current.component(.year, from: Soldate as Date))
    
    let lunaClass = getLuna()
    if let result = lunaClass.getLunadate(year: solYear, month: solMonth, day: solDay){
        returnLunaDate = result
    }
    
    return returnLunaDate
}


class getLuna: NSObject, XMLParserDelegate {

    var parser = XMLParser()
    var resultLunDay = ""
    var resultLunMonth = ""
    var passDay = false
    var passMonth = false
    var currentElement = ""

    func getLunadate(year: String, month: String, day: String) -> String? {
        
        let url:String="http://apis.data.go.kr/B090041/openapi/service/LrsrCldInfoService/getLunCalInfo?solYear=\(year)&solMonth=\(month)&solDay=\(day)&ServiceKey=L3yenB0Fz9D%2FwJaFHlnO8IzOsDDn450ztIgf%2BGnz9l%2FMsoaelcJkrMqiLdLlSvakSHfPDmSTCf85djFS2mfFvA%3D%3D"
        
        let urlToSend: URL = URL(string: url)!
        
        // Parse the XML
        parser = XMLParser(contentsOf: urlToSend)!
        parser.delegate = self
        
        let success:Bool = parser.parse()
        
        if success {
            print("parse success!")
            return String("\(resultLunMonth)/\(resultLunDay)")
        } else {
            print("parse failure!")
            return nil
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //currentElement = elementName;
        //print(currentElement)
        
        if (elementName == "lunDay" || elementName ==  "response" || elementName == "body" || elementName == "items" || elementName == "item" || elementName == "lunMonth"){
            if elementName == "lunDay" {
                passDay = true
            }
            if elementName == "lunMonth" {
                passMonth = true
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //currentElement = ""
        if (elementName == "lunDay" || elementName ==  "response" || elementName == "body" || elementName == "items" || elementName == "item" || elementName == "lunMonth"){
            if elementName == "lunDay" {
                passDay = false
            }
            if elementName == "lunMonth" {
                passMonth = false
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (passDay) {
            resultLunDay = string
        }
        
        if (passMonth) {
            resultLunMonth = string
        }
    }

    
}









