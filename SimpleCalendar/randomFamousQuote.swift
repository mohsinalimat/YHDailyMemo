//
//  randomFamousQuote.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 9. 4..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit


func getRandomQuote(completionHandler: @escaping (_ results: String?, _ error: NSError?) -> Void ) {
    
    let request = NSMutableURLRequest(url: URL(string: "http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1")!)
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
        if error == nil {
            guard let data = data else {
                return
            }
            
            //Raw JASON to JSON
            let rawData = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
            let rawData2 = rawData.replacingOccurrences(of: "[", with: "")
            let rawData3 = rawData2.replacingOccurrences(of: "]", with: "")
            let rawData4 = rawData3.replacingOccurrences(of: "&#8217;", with: "'")
            
            //JSON to Dictionary
            let newData = converToDictionary(rawData4 as String)
            
            let quote = "\(String(describing: newData!["content"]!)) -\(String(describing: newData!["title"]!))"
            
            //return data
            completionHandler(quote, nil)
            
        }else {
            //Error
            completionHandler("", error as NSError?)
        }
    })
    task.resume()
}


func converToDictionary(_ text: String) -> [String:Any]?{
    if let data = text.data(using: .utf8){
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        } catch {
            print("ConvertToDictionary Error: " + error.localizedDescription)
        }
    }
    return nil
}
