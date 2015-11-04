//: Playground - noun: a place where people can play

import UIKit
import Foundation

class whatever {
}


class ParseJSON {
    
    static func loadJSONFromBundle(filename: String) {
        
        
        
        guard let data = NSData(contentsOfFile: path) else {
            print("Could not find level file: \(filename)")
        }
        
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            //Use your dictionary here.
            print("JSON : \(jsonDictionary)")
            
        }
        catch  {
            print("wheeeeee, I am broke")
            //Handle any error.
        }
        // return jsonDictionary
    }
    
    func getTheData(filename: String) {
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
            print("\(path)")
        } else {
            print("Can't find path to \(filename)")
        }
    }
    
}