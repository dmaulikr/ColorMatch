//
//  GameScene.swift
//  Color Match
//
//  Created by Zach Johnson on 5/30/17.
//  Copyright © 2017 zsjohnson.me. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var movingBar = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        movingBar = self.childNode(withName: "movingBar") as! SKSpriteNode
        self.view?.allowsTransparency = true
        self.view?.backgroundColor = UIColor.clear
        self.scene?.backgroundColor = UIColor.clear
        
        // Get label node from scene and store it for use later
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            movingBar.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            movingBar.run(SKAction.moveTo(x: location.x, duration: 0))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
