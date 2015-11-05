//
//  Swap.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/3/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

import Foundation

struct Swap: CustomStringConvertible {
    let cookieA: Cookie
    let cookieB: Cookie
    
    init(cookieA: Cookie, cookieB: Cookie) {
        self.cookieA = cookieA
        self.cookieB = cookieB
    }
    
    var description: String {
        return "swap \(cookieA) with \(cookieB)"
    }
}
