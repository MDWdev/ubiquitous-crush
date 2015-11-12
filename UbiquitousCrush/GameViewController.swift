//
//  GameViewController.swift
//  UbiquitousCrush
//
//  Created by Melissa on 11/3/15.
//  Copyright (c) 2015 Melissa Webster. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import GameKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var level: Level!
    var movesLeft = 0
    var score = 0
    var levelCount = 0
    var currentLevel = SingleStats.sharedInstance.levelReached
    
    
    
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    lazy var backgroundMusic: AVAudioPlayer = {
        let url = NSBundle.mainBundle().URLForResource("Mining by Moonlight", withExtension: "mp3")
        do {
            let player = try AVAudioPlayer(contentsOfURL: url!)
            player.prepareToPlay()
            player.volume = 0.2
            return player
        }
        catch {
            fatalError ("Error loading \(url): \(error)")
        }
    }()
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameOverPanel: UIImageView!
    @IBOutlet weak var shuffleButton: UIButton!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }
    
    override func viewWillAppear(animated: Bool) {
        print(NSUserDefaults.standardUserDefaults().boolForKey("playMusic"))
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func playMusic() {
        if NSUserDefaults.standardUserDefaults().boolForKey("playMusic") == true {
            backgroundMusic.play()
        }
    }
    
    func configureView() {
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        shuffleButton.hidden = true
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        let thisLevel = callLevel(levelCount)
        scene.level = thisLevel
        scene.addTiles()
        scene.swipeHandler = handleSwipe
        gameOverPanel.hidden = true
        
        // Present the scene.
        skView.presentScene(scene)
        
        // Play the music
        playMusic()
        startLevel()
    }
    
    func callLevel(levelNumber: Int) -> Level {
        print("level # in callLevel: \(levelNumber)")
        // take 1 away from levelNumber to instantiate correct level file
        level = Level(filename: "Level_\(levelNumber)")
        return level
    }
    
    func startLevel() {
        movesLeft = level.maximumMoves
        score = 0
        updateLabels()
        level.resetComboMultiplier()
        scene.animateStartLevel() {
            self.shuffleButton.hidden = false
        }
        shuffle()
    }
    
    func shuffle() {
        scene.removeAllCookieSprites()
        let newCookies = level.shuffle()
        scene.addSpritesForCookies(newCookies)
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
        if chains.count == 0 {
            beginNextSwapAttempt()
            return
        }
        scene.animateMatchedCookies(chains) {
            for chain in chains {
                self.score += chain.score
            }
            self.updateLabels()
            let columns = self.level.fillHoles()
            self.scene.animateFallingCookies(columns) {
                let columns = self.level.topUpCookies()
                self.scene.animateNewCookies(columns) {
                    self.handleMatches()
                }
            }
        }
    }
    
    func decrementMoves() {
        --movesLeft
        updateLabels()
        if score >= level.targetScore {
            levelCount++
            SingleStats.sharedInstance.levelScore = score
            SingleStats.sharedInstance.refreshStats(levelCount, newScore: score)
            print("Current level after beat level: \(SingleStats.sharedInstance.levelReached)")
            gameOverPanel.image = UIImage(named: "LevelComplete")
            showLevelOver()
        } else if movesLeft == 0 {
            gameOverPanel.image = UIImage(named: "LevelLost")
            showLevelOver()
        }
    }
    
    func beginNextSwapAttempt() {
        level.resetComboMultiplier()
        level.detectPossibleSwaps()
        view.userInteractionEnabled = true
        decrementMoves()
    }
    
    func updateLabels() {
        targetLabel.text = String(format: "%ld", level.targetScore)
        movesLabel.text = String(format: "%ld", movesLeft)
        scoreLabel.text = String(format: "%ld", score)
    }
    
    func showLevelOver() {
        gameOverPanel.hidden = false
        scene.userInteractionEnabled = false
        shuffleButton.hidden = true
        scene.animateLevelOver() {
            self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showScoreScreen")
            self.view.addGestureRecognizer(self.tapGestureRecognizer)
        }
    }
    
    func hideLevelOver() {
        view.removeGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer = nil
        gameOverPanel.hidden = true
        scene.userInteractionEnabled = true
    }
    
    func backToLevelPicker() {
        stopMusic()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shuffleButtonPressed(_: AnyObject) {
        shuffle()
        decrementMoves()
    }
    
    func stopMusic() {
        if backgroundMusic.playing {
            backgroundMusic.stop()
        }
    }
    
    func showScoreScreen() {
        performSegueWithIdentifier("showScore", sender: nil)
    }
}
