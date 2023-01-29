//
//  Island.swift
//  Plane Game
//
//  Created by Abraham Alfred Babu on 2023-01-29.
//

import Foundation
import SpriteKit
import GameplayKit

class Island:GameObject{
    
    init(){
        super.init(imageString: "island", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been initialized for game object Island")
    }
    
    override func Start() {
        zPosition = Layer.island.rawValue
        verticalSpeed = 5.0
        Reset()
    }
    
    override func Update() {
        Move()
        CheckBounds()
    }
    
    override func CheckBounds() {
        if(position.y <= -876){
            Reset()
        }
    }
    
    override func Reset() {
        position.y = 876
        
        let radomX: Int = (randomSource?.nextInt(upperBound: 626))! - 313
        position.x = CGFloat(radomX)
        isColliding = false
    }
    
    func Move(){
        position.y -= verticalSpeed!
    }
}
