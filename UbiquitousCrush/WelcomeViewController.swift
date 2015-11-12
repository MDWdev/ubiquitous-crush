//
//  WelcomeViewController.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/11/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonPress(sender: UIButton) {
        if sender.tag == 0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC: UIViewController = storyboard.instantiateViewControllerWithIdentifier("LevelSelectView") as! LevelSelectViewController
            
            self.presentViewController(nextVC, animated: true, completion: nil)
        }
        else if sender.tag == 1 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:  nil)
            let nextVC: UIViewController = storyboard.instantiateViewControllerWithIdentifier("InfoView") as! InfoViewController
            
            presentViewController(nextVC, animated: true, completion: nil)
            
        }
    }
}
