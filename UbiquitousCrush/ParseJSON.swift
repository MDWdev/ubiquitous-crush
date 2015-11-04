////
////  ParseJSON.swift
////  UbiquitousCrush
////
////  Created by Melissa on 11/4/15.
////  Copyright © 2015 Melissa Webster. All rights reserved.
////
////
import Foundation

struct ParseJSON {
    var newDictionary = NSDictionary?()
    var newData = NSData?()
    
    func loadJSONFromBundle(firstData: String) -> Dictionary<String, AnyObject> {
        let newPath = getThePath(firstData)
        print(newPath)
        let newData = getTheData(newPath)
        print(newData.description)
        let newDict = makeTheDictionary(newData)
        print(newDict.description)
        return newDict
    }
    
    func getThePath(filename: String) -> String {
        var path = String()
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
            print("\(path)")
            //            return path
        } else {
            print("Can't find path to \(filename)")
        }
        return path
    }
    
    func getTheData(pathname: String) -> NSData {
        var data: NSData?
        if let data = NSData(contentsOfFile: pathname) {
            print("")
            //            return data
        } else {
            print("Couldn't find file at path \(pathname)")
        }
        return data!
    }
    
    func makeTheDictionary(dataFile: NSData) -> Dictionary<String, AnyObject> {
        var jsonDict: Dictionary<String, AnyObject>?
        do {
            let jsonDict = try NSJSONSerialization.JSONObjectWithData(dataFile, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String, AnyObject>
            if let jsonDict = jsonDict {
                print("something worked...")
                // work with dictionary here
                //return jsonDict
            } else {
                // more error handling
                print("This didn't work 1")
            }
        } catch let error as NSError {
            // error handling
            print("This didn't work 2 either, with error \(error)")
        }
        return jsonDict!
    }

    
}

