//
//  InfoViewController.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/11/15.
//  Copyright © 2015 Melissa Webster. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var soundEffectsSwitch: UISwitch!
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var soundEffectsOffLabel: UILabel!
    @IBOutlet weak var soundEffectsOnLabel: UILabel!
    @IBOutlet weak var musicOffLabel: UILabel!
    @IBOutlet weak var musicOnLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        soundEffectsOffLabel.hidden = true
        musicOffLabel.hidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundEffectsSwitch.addTarget(self, action: Selector("soundStateChanged:"), forControlEvents: .ValueChanged)
        musicSwitch.addTarget(self, action: Selector("musicStateChanged:"), forControlEvents: .ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func soundStateChanged(switchState: UISwitch) {
        if switchState.on {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "playSounds")
            soundEffectsOnLabel.hidden = false
            soundEffectsOffLabel.hidden = true
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "playSounds")
            soundEffectsOnLabel.hidden = true
            soundEffectsOffLabel.hidden = false
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        print(NSUserDefaults.standardUserDefaults().boolForKey("playSounds"))
    }
    
    func musicStateChanged(switchState: UISwitch) {
        if switchState.on {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "playMusic")
            musicOnLabel.hidden = false
            musicOffLabel.hidden = true
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "playMusic")
            musicOnLabel.hidden = true
            musicOffLabel.hidden = false
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        print(NSUserDefaults.standardUserDefaults().boolForKey("playMusic"))
    }
    
    @IBAction func dismissView(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
