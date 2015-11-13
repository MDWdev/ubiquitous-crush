//
//  ScoreScreen.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/12/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

import UIKit
import GameKit

class ScoreScreen: UIViewController, GKGameCenterControllerDelegate {
    
    var gcEnabled = Bool() // Stores if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Stores the default leaderboardID
    
    var scoreToLeaderboard = SingleStats.sharedInstance.levelScore
    var levelUserReached = SingleStats.sharedInstance.levelReached

    @IBOutlet weak var levelReachedLabel: UILabel!
    @IBOutlet weak var levelScoreLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        levelReachedLabel.text = "\(levelUserReached)"
        levelScoreLabel.text = "\(scoreToLeaderboard)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        switch (sender.tag) {
        case 0: showLeader()
        case 1: dismissScoreScreen()
        default: self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    func dismissScoreScreen() {
        // calls the unwind segue
    }
    
    //shows leaderboard screen
    func showLeader() {
        saveHighscore(scoreToLeaderboard)
        let gc: GKGameCenterViewController = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        gc.viewState = GKGameCenterViewControllerState.Leaderboards
        gc.leaderboardIdentifier = "ubiquitousCrushLeaderboard_01"
        self.presentViewController(gc, animated: true, completion: nil)
    }
    
    //hides leaderboard screen
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func saveHighscore(score:Int) {
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "ubiquitousCrushLeaderboard_01")
            scoreReporter.value = Int64(score) //score variable here (same as above)
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error) -> Void in
                if error != nil {
                    print("error")
                }
            })
        }
    }
    
    
    //initiate gamecenter
    func authenticateLocalPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if (viewController != nil) {
                self.presentViewController(viewController!, animated: true, completion: nil)
            }
            else {
                print((GKLocalPlayer.localPlayer().authenticated))
            }
        }
    }
}
