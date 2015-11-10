//
//  LevelSelectViewController.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/10/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

import UIKit

class LevelSelectViewController: UIViewController {
    
    var levelChoice = 0
    
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    @IBOutlet weak var level4Button: UIButton!
    @IBOutlet weak var level5Button: UIButton!
    @IBOutlet weak var level6Button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        let levelSelectButtons = [level1Button, level2Button, level3Button, level4Button, level5Button, level6Button]
        levelChoice++
        print("level at viewWillAppear in Level Select: \(levelChoice)")
        for button in levelSelectButtons {
            if levelChoice >= button.tag {
                button.hidden = false
            } else {
                button.hidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func levelToPlayButtonPress(sender: UIButton) {
        levelChoice = sender.tag
        print(levelChoice)
        
        let alert = UIAlertController(title: "",
            message: "Level: \(levelChoice)",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Play",
            style :UIAlertActionStyle.Default,
            handler: { action in self.playGame(self.levelChoice)
        }))
        presentViewController(alert, animated: true, completion:nil)
    }

    func playGame(number: Int) {
        self.performSegueWithIdentifier("playGame", sender: nil)
    }
    
//     MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playGame" {
            let vc = segue.destinationViewController as! GameViewController
            vc.levelCount = levelChoice
        }
    }


}
