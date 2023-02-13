//
//  GameViewController.swift
//  Plane Game
//
//  Created by Abraham Alfred Babu on 2023-01-22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var currentScene: GKScene!
    
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentStartScene()
        
        CollisionManager.gameViewController = self
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func updateLivesLabel(){
        livesLabel.text = "Lives: \(ScoreManager.lives)"
    }
    
    func updateScoreLabel(){
        scoreLabel.text = "Score: \(ScoreManager.score)"
    }
    
    func setScene(sceneName: String) -> Void {
        currentScene = GKScene(fileNamed: sceneName)
    
        if let scene = currentScene!.rootNode as! SKScene?{
            scene.scaleMode = .aspectFill
            if let view = self.view as! SKView?{
                view.presentScene(scene)
                view.ignoresSiblingOrder = true
            }
        }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startLabel.isHidden = true
        startButton.isHidden = true
        
        scoreLabel.isHidden = false
        livesLabel.isHidden  = false
        
        ScoreManager.score = 0
        ScoreManager.lives = 5
        updateLivesLabel()
        updateScoreLabel()
        
        setScene(sceneName: "GameScene")
    }
    
    func presentStartScene(){
        scoreLabel.isHidden = true
        livesLabel.isHidden = true
        startLabel.isHidden = false
        startButton.isHidden = false
        setScene(sceneName: "StartScene")
    }
    
    func presentEndScene(){
        
    }
}
