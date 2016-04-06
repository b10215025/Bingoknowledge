//
//  ProcessJSON.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import Foundation
//provide method for JSON format 
class ProcessJSON {
    
    //JSON to NSData
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    //NSdata to NSArray
    func parseJSON(inputData: NSData) -> NSArray{
        var boardsDictionary: NSArray = NSArray()
        do {
            boardsDictionary = try NSJSONSerialization.JSONObjectWithData(inputData,  options: NSJSONReadingOptions.MutableContainers) as! NSArray
        } catch  {
            print("Error message:Can't not transfer to NSArray from NSData !")
        }
        return boardsDictionary
    }
    func ProcessJSON(){
        //init
    }
    
    
}