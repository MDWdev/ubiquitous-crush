//
//  GameViewController.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/3/15.
//  Copyright (c) 2015 Melissa Webster. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var level: Level!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        let newCookies = level.shuffle()
        scene.addSpritesForCookies(newCookies)
    }
    
// Comment >1<
//    override func supportedInterfaceOrientations() -> Int {
//        return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
//    }
    
    // use this instead of return as Int? Save >1< commented code unless that doesn't work!
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        level = Level(filename: "Level_1")
        scene.level = level
        scene.addTiles()
        
        scene.swipeHandler = handleSwipe
        
        // Present the scene.
        skView.presentScene(scene)
        
        beginGame()
    }
    
    func handleSwipe(swap: Swap) {
        view.userInteractionEnabled = false
        
        if level.isPossibleSwap(swap) {
            level.performSwap(swap)
            scene.animateSwap(swap, completion: handleMatches)
            self.view.userInteractionEnabled = true
        
        } else {
            scene.animateInvalidSwap(swap) {
                self.view.userInteractionEnabled = true
            }
        }
        
    }
    
    func handleMatches() {
        let chains = level.removeMatches()
        
        scene.animateMatchedCookies(chains) {
            self.view.userInteractionEnabled = true
        }
    }
}
