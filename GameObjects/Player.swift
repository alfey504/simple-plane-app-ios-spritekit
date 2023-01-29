//
//  Player.swift
//  Plane Game
//
//  Created by Abraham Alfred Babu on 2023-01-22.
//

import Foundation
import SpriteKit
import GameplayKit

class Player: GameObject{
    
    init(){
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start() {
        zPosition = Layer.plane.rawValue
        Reset()
    }
    
    override func Update() {
        CheckBounds()
    }
    
    override func CheckBounds() {
        if(position.x <= -255){
            position.x = -255
        }
        
        if(position.x >= 255){
            position.x = 255
        }
    }
    
    override func Reset() {
        position.y = -495
    }
    
    func TouchMove(newPos: CGPoint){
        run(SKAction.move(to: newPos, duration: 0.05))
//        position = newPos
    }
}
