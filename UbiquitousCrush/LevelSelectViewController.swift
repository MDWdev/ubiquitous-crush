//
//  LevelSelectViewController.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/10/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

import UIKit

class LevelSelectViewController: UIViewController {
    
    var currentLevel = SingleStats.sharedInstance.levelReached
    var levelChoice = Int()
    
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
        currentLevel = SingleStats.sharedInstance.levelReached
        print("level at viewWillAppear in Level Select: \(currentLevel)")
        print("Most recent score stored now back in Level Select: \(SingleStats.sharedInstance.levelScore)")
        
        for button in levelSelectButtons {
            if currentLevel >= button.tag {
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
        // button.tag's match with level file numbering ie: button for level 1, tag = 0, file to play = Level_0
        levelChoice = sender.tag
        if levelChoice == currentLevel {
            let alert = UIAlertController(title: "\(levelChoice + 1)",
                message: "Good Luck!",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Play",
                style :UIAlertActionStyle.Default,
                handler: { action in self.playGame(self.currentLevel)
            }))
            presentViewController(alert, animated: true, completion:nil)
        }
        else {
            let alert = UIAlertController(title: "\(levelChoice)",
            message:  "Are You Sure?",
            preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Yes",
                style: UIAlertActionStyle.Default,
                handler: { action in self.playGame(self.levelChoice)
            }))
            alert.addAction(UIAlertAction(title: "No",
                style: UIAlertActionStyle.Cancel,
                handler: { action in self.dismissViewControllerAnimated(false, completion: nil)
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
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
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }


}
