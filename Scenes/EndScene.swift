//
//  StartScene.swift
//  Plane Game
//
//  Created by Abraham Alfred Babu on 2023-02-12.
//

import Foundation
import SpriteKit
import AVFoundation
import GameplayKit


class EndScene: SKScene {
    
    private var ocean1: Ocean?
    private var ocean2: Ocean?
    
    override func didMove(to view: SKView) {
        
        
        name = "END"
        
        ocean1 = Ocean()
        ocean1?.Start()
        ocean1?.Reset()
        addChild(ocean1!)
        
        ocean2 = Ocean()
        ocean2?.Start()
        ocean2?.position.y = -773
        addChild(ocean2!)
    
        
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
    }
    
    func touchMoved(toPoint pos : CGPoint){
    }
    
    func touchUp(atPoint pos : CGPoint){
    
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
    }
}
