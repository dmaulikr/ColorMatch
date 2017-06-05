//
//  GameScene.swift
//  Color Match
//
//  Created by Zach Johnson on 5/30/17.
//  Copyright © 2017 zsjohnson.me. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation


class GameScene: SKScene {
    
    
    static var charColorL = SKSpriteNode()
    static var bgColorL = SKSpriteNode()
    static var charColorR = SKSpriteNode()
    static var bgColorR = SKSpriteNode()
    
    static func setColor(to color: UIColor){
        charColorL.color = color
        charColorR.color = color
    }
    
    override func didMove(to view: SKView) {
        
        
        GameScene.charColorL = self.childNode(withName: "charColorL") as! SKSpriteNode
        GameScene.bgColorL = self.childNode(withName: "bgColorL") as! SKSpriteNode
        GameScene.charColorR = self.childNode(withName: "charColorR") as! SKSpriteNode
        GameScene.bgColorR = self.childNode(withName: "bgColorR") as! SKSpriteNode
        
        //GameLogic.getNewColor()
        
        self.view?.allowsTransparency = true
        self.view?.backgroundColor = UIColor.clear
        self.scene?.backgroundColor = UIColor.clear
        
        // Get label node from scene and store it for use later
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            GameScene.charColorL.run(SKAction.moveTo(x: location.x - 10, duration: 0))
            GameScene.bgColorL.run(SKAction.moveTo(x: location.x - 15, duration: 0))
            GameScene.charColorR.run(SKAction.moveTo(x: location.x + 10, duration: 0))
            GameScene.bgColorR.run(SKAction.moveTo(x: location.x + 15, duration: 0))
            
            /*
            if (abs(location.x - GameLogic.currentLocation.x) < 10){
                GameScene.bgColorR.color = UIColor.red
                GameScene.bgColorL.color = UIColor.red
            }*/
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            GameScene.charColorL.run(SKAction.moveTo(x: location.x - 19, duration: 0))
            GameScene.bgColorL.run(SKAction.moveTo(x: location.x - 24, duration: 0))
            GameScene.charColorR.run(SKAction.moveTo(x: location.x + 19, duration: 0))
            GameScene.bgColorR.run(SKAction.moveTo(x: location.x + 24, duration: 0))
            
            /*
            if (abs(location.x - GameLogic.currentLocation.x) < 10){
                GameScene.bgColorR.color = UIColor.red
                GameScene.bgColorL.color = UIColor.red
            }*/
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
