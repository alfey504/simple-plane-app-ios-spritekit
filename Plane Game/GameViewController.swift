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
    
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
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
       presentGameScene()
    }
    
    @IBAction func restartButtonPressed(_ sender: Any) {
        presentGameScene()
    }
    
    func presentGameScene(){
        setGameSceneLabels(isHidden: false)
        setStarScreenLabels(isHidden: true)
        setEndLabels(isHidden: true)
        
        ScoreManager.score = 0
        ScoreManager.lives = 5
        updateLivesLabel()
        updateScoreLabel()
        
        setScene(sceneName: "GameScene")
    }
    
    func presentStartScene(){
        setGameSceneLabels(isHidden: true)
        setStarScreenLabels(isHidden: false)
        setEndLabels(isHidden: true)
        setScene(sceneName: "StartScene")
    }
    
    func presentEndScene(){
        setStarScreenLabels(isHidden: true)
        setGameSceneLabels(isHidden: false)
        setEndLabels(isHidden: false)
        
        setScene(sceneName: "EndScene")
        
    }
    
    func setGameSceneLabels(isHidden: Bool){
        scoreLabel.isHidden = isHidden
        livesLabel.isHidden = isHidden
        
    }
    
    func setStarScreenLabels(isHidden: Bool){
        startLabel.isHidden = isHidden
        startButton.isHidden = isHidden
        startButton.isUserInteractionEnabled = !isHidden
    }
    
    func setEndLabels(isHidden: Bool){
        endLabel.isHidden = isHidden
        restartButton.isHidden = isHidden
    }
}
