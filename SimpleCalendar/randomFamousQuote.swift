//
//  randomFamousQuote.swift
//  SimpleCalendar
//
//  Created by Hyun sung Yi on 2017. 9. 4..
//  Copyright © 2017년 Yohan Hyunsung Yi. All rights reserved.
//

import Foundation
import UIKit

func getRandomQuote(completionHandler: @escaping (_ success: Bool,_ result: String,_ errorMessage: String?) -> Void ){
    
    // create session and request
    let session = URLSession.shared
    
    let request = URLRequest(url: URL(string:"http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1")!)
    
    // create network request
    let task = session.dataTask(with: request) { (data, response, error) in
        
        // if an error occurs, print it and re-enable the UI
        func displayError(_ error: String) {
            print(error)
            completionHandler(false, "", error)
        }
        
        /* GUARD: Was there an error? */
        guard (error == nil) else {
            displayError("There was an error with your request: \(String(describing: error))")
            return
        }
        
        /* GUARD: Did we get a successful 2XX response? */
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            displayError("Your request returned a status code other than 2xx!")
            return
        }
        
        /* GUARD: Was there any data returned? */
        guard let data = data else {
            displayError("No data was returned by the request!")
            return
        }
        
        // parse the data
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
        } catch {
            displayError("Could not parse the data as JSON: '\(data)'")
            return
        }
        
        completionHandler(true, "\(String(describing: parsedResult["content"])) -\(String(describing: parsedResult["title"]))", nil)
    }
    
    // start the task!
    task.resume()
}
