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
    
    
    
    static func setColor(){
        let color = GameLogic.getNewColor()
        let newColorAction = SKAction.colorize(with: color, colorBlendFactor: 1, duration: 4)
        charColorR.run(newColorAction)
        charColorL.run(newColorAction)
    }
    
    /*
     *   Transition between gradients.
     *   Takes current score to determine difficulty of next gradient
     *   The higher the score, the more colors in the gradient
     */
    static func changeGradients(){
        let growth = SKAction.resize(toWidth: GameViewController.theView!.bounds.width * 2, duration: 1)
        let shrink = SKAction.resize(toWidth: 15, duration: 1)
        let newColor = GameLogic.getNewColor()
        let whiteAni = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 4)
        let newColorAni = SKAction.colorize(with: newColor, colorBlendFactor: 1, duration: 4)
        let pause = SKAction.wait(forDuration: 5)
        charColorL.run(growth)
        charColorR.run(growth)
        charColorL.run(whiteAni)
        charColorR.run(whiteAni)
        
        GameViewController.getNewGradient()
        charColorR.run(pause, completion: {
            charColorR.run(shrink)
            charColorR.run(newColorAni)})
        charColorL.run(pause, completion: {
            charColorL.run(shrink)
            charColorL.run(newColorAni)})
        
        
    }
    
    
    override func didMove(to view: SKView) {
        
        
        GameScene.charColorL = self.childNode(withName: "charColorL") as! SKSpriteNode
        GameScene.bgColorL = self.childNode(withName: "bgColorL") as! SKSpriteNode
        GameScene.charColorR = self.childNode(withName: "charColorR") as! SKSpriteNode
        GameScene.bgColorR = self.childNode(withName: "bgColorR") as! SKSpriteNode
        
        GameLogic.getNewColor()
        
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
            
            
            check(location: location.x)
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            GameScene.charColorL.run(SKAction.moveTo(x: location.x - 19, duration: 0))
            GameScene.bgColorL.run(SKAction.moveTo(x: location.x - 24, duration: 0))
            GameScene.charColorR.run(SKAction.moveTo(x: location.x + 19, duration: 0))
            GameScene.bgColorR.run(SKAction.moveTo(x: location.x + 24, duration: 0))
            
            check(location: location.x)
            
        }
    }
    
    func check(location: CGFloat){
        if (abs(location - GameLogic.currentLocation.x) < 10){
            GameLogic.gotCorrectColor()
            //GameScene.bgColorR.color = UIColor.red
            //GameScene.bgColorL.color = UIColor.red
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
