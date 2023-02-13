//
//  CollisionManager.swift
//  Plane Game
//
//  Created by Abraham Alfred Babu on 2023-02-05.
//

import Foundation
import GameplayKit

class CollisionManager{
    
    public static var gameViewController: GameViewController?
    
    public static func squaredDistance(point1: CGPoint, point2: CGPoint) -> CGFloat{
        let Xs: CGFloat = point2.x - point1.x
        let Ys: CGFloat = point2.y - point1.y
        
        return (Xs * Xs) + (Ys * Ys)
    }
    
    public static func squaredRadiusCheck(scene: SKScene, object1: GameObject, object2: GameObject){
        let p1 = object1.position
        let p2 = object2.position
        
        let p1Radius = object1.halfHeight!
        let p2Radius = object2.halfHeight!
        
        let radii = p1Radius + p2Radius
        
        if(squaredDistance(point1: p1, point2: p2) < radii * radii){
            
            if(!object2.isColliding!){
                switch(object2.name){
                    case "island":
                        print("Collision Manger -> squaredRadiusCheck -> Collision with Island")
                        scene.run(SKAction.playSoundFileNamed("yay", waitForCompletion: false))
                        ScoreManager.score += 100
                        if(ScoreManager.score % 200 == 0){
                            ScoreManager.lives += 1
                            gameViewController?.updateLivesLabel()
                        }
                        gameViewController?.updateScoreLabel()
                        break
                    case "cloud":
                        print("Collision Manger -> squaredRadiusCheck -> Collision with cloud")
                        scene.run(SKAction.playSoundFileNamed("thunder", waitForCompletion: false))
                        ScoreManager.lives -= 1
                        if(ScoreManager.lives <= 0){
                            gameViewController?.presentEndScene()
                        }
                    
                        gameViewController?.updateLivesLabel()
                        break
                    default:
                        print("Collision Manger -> squaredRadiusCheck -> Collision case default")
                        break   
                }
                object2.isColliding = true
            }
        }
    }
}
