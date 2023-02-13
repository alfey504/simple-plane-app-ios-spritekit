//
//  GameScene.swift
//  Plane Game
//
//  Created by Abraham Alfred Babu on 2023-01-22.
//

import SpriteKit
import AVFoundation
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

class GameScene: SKScene {
    
    private var ocean1: Ocean?
    private var ocean2: Ocean?
    var player: Player?
    var island: Island?
    var clouds: [Cloud] = []
    
    override func didMove(to view: SKView) {
        
        screenWidth = frame.width
        screenHeight = frame.height
        
        name = "GAME"
        
        ocean1 = Ocean()
        ocean1?.Start()
        ocean1?.Reset()
        addChild(ocean1!)
        
        ocean2 = Ocean()
        ocean2?.Start()
        ocean2?.position.y = -773
        addChild(ocean2!)
        
        player = Player()
        player?.Start()
        addChild(player!)
        
        island = Island()
        addChild(island!)
        
        for _ in 0...2{
            let cloud = Cloud()
            clouds.append(cloud)
            addChild(cloud)
        }
        
        let engineSound = SKAudioNode(fileNamed: "engine.mp3")
        addChild(engineSound)
        engineSound.autoplayLooped = true
        engineSound.run(SKAction.changeVolume(by: 0.5, duration: 0))
        
        do{
            let sounds: [String] = ["thunder", "yay"]
            for sound in sounds{
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
                let avPlayer: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                avPlayer.prepareToPlay()
            }
        }catch{
            print("GameScene -> didMove() -> failed to load audio")
        }
    }
    
    func touchDown(atPoint pos : CGPoint){
        player?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
    }
    
    func touchMoved(toPoint pos : CGPoint){
        player?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
        
    }
    
    func touchUp(atPoint pos : CGPoint){
        player?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        ocean1?.Update()
        ocean2?.Update()
        player?.Update()
        
        island?.Update()
        CollisionManager.squaredRadiusCheck(scene: self, object1: player!, object2: island!)
        
        for cloud in clouds{
            cloud.Update()
            CollisionManager.squaredRadiusCheck(scene: self, object1: player!, object2: cloud)
        }
    }
}
