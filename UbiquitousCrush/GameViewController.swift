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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
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
        
        // Present the scene.
        skView.presentScene(scene)
    }
}
