////
////  Extensions.swift
////  UbiquitousCrush
////
////  Created by Melissa on 11/3/15.
////  Copyright © 2015 Melissa Webster. All rights reserved.
////

import Foundation

extension Dictionary {
    static func loadJSONFromBundle(filename: String) -> Dictionary<String, AnyObject>? {
    var dataOK: NSData
    var dictionaryOK: NSDictionary = NSDictionary()
    if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
    let _: NSError?
    //let data = NSData(contentsOfFile: path, options: NSDataReadingOptions(), error: &error)
    do {
        let data = try NSData(contentsOfFile: path, options: NSDataReadingOptions()) as NSData!
        dataOK = data
    }
    catch {
        print("Could not load level file: \(filename), error: \(error)")
        return nil
    }
    do {
        let dictionary = try NSJSONSerialization.JSONObjectWithData(dataOK, options: NSJSONReadingOptions()) as AnyObject!
        dictionaryOK = (dictionary as! NSDictionary as? Dictionary<String, AnyObject>)!
    }
    catch {
        print("Level file '\(filename)' is not valid JSON: \(error)")
        return nil
        } 
    } 
        return dictionaryOK as? Dictionary<String, AnyObject>
    } 
}
//extension Dictionary {
//    //    var newDictionary = NSDictionary?()
//    //    var newData = NSData?()
//    
//    func loadJSONFromBundle(firstData: String) -> NSDictionary {
//        let newPath = getThePath(firstData)
//        print(newPath)
//        let newData = getTheData(newPath)
//        print(newData.description)
//        let newDict = makeTheDictionary(newData)
//        print(newDict.description)
//        return (newDict as? NSDictionary)!
//    }
//    
//    func getThePath(filename: String) -> String {
//        var path = String()
//        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
//            print("\(path)")
//            //            return path
//        } else {
//            print("Can't find path to \(filename)")
//        }
//        print(path)
//        return path
//    }
//    
//    func getTheData(pathname: String) -> NSData {
//        var data: NSData?
//        if let data = NSData(contentsOfFile: pathname) {
//            print("")
//            //            return data
//        } else {
//            print("Couldn't find file at path \(pathname)")
//        }
//        return data!
//    }
//    
//    func makeTheDictionary(dataFile: NSData) -> Dictionary<String, AnyObject> {
//        var jsonDict: Dictionary<String, AnyObject>?
//        do {
//            let jsonDict = try NSJSONSerialization.JSONObjectWithData(dataFile, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String, AnyObject>
//            if let jsonDict = jsonDict {
//                print("something worked...")
//                // work with dictionary here
//                //return jsonDict
//            } else {
//                // more error handling
//                print("This didn't work 1")
//            }
//        } catch let error as NSError {
//            // error handling
//            print("This didn't work 2 either, with error \(error)")
//        }
//        return jsonDict!
//    }
//    
//    
//    
//    
//}


