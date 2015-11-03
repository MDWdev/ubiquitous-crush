//
//  Cookie.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/3/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

import SpriteKit

enum CookieType: Int, CustomStringConvertible {
    case Unknown = 0, PawPrint, YingYang, Clover, Flower, Crown, Butterfly
    
    var spriteName: String {
        let spriteNames = [
            "PawPrint",
            "YingYang",
            "Clover",
            "Flower",
            "Crown",
            "Butterfly"]
        return spriteNames[rawValue - 1]
    }
    
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }
    
    var description: String {
        return spriteName
    }
    
    static func random() -> CookieType {
        return CookieType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
}

// Printable has been changed to CustomStringConvertible

class Cookie: CustomStringConvertible {
    var column: Int
    var row: Int
    let cookieType: CookieType
    var sprite: SKSpriteNode?
    
    var description: String {
        return "type:\(cookieType) square:(\(column),\(row))"
    }
    
    init(column: Int, row: Int, cookieType: CookieType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
}
