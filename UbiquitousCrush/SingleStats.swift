//
//  SingleStats.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/11/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

class SingleStats {
    static let sharedInstance = SingleStats()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    var levelScore = 0
    var levelReached = 0
    var scoresArray = [Int]()
    
    func updateScoresArray(currentScore: Int) {
        self.scoresArray.append(currentScore)
    }
    
    func refreshStats(newLevel: Int, newScore: Int) {
        self.levelReached = newLevel
        self.updateScoresArray(newScore)
    }
    
    func resetStats() {
        self.levelScore = 0
        self.levelReached = 0
    }
}
