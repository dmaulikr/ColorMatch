//
//  Controller.swift
//  Color Match
//
//  Created by Zach Johnson on 6/4/17.
//  Copyright © 2017 zsjohnson.me. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameLogic {
    
    static var score: Int = 0
    
    static var currentLocation: CGPoint = CGPoint.init(x: 0, y: 0)
    
    static func randomNumber(MIN: Int, MAX: Int)-> Int{
        return Int(arc4random_uniform(UInt32(MAX)) + UInt32(MIN));
    }
    
    static func getNewLocation() -> CGPoint {
    
        let intpx:Double = Double(randomNumber(MIN: 0, MAX: 101)) / 100.0
        let intpy:Double = Double(randomNumber(MIN: 0, MAX: 101)) / 100.0
        let intpositive = randomNumber(MIN: 0, MAX: 2)
        
        print("px: \(intpx) py: \(intpy)\n\n")
        
        var randx: Double = Double(GameViewController.theView!.bounds.maxX) * intpx
        let randy: Double = Double(GameViewController.theView!.bounds.maxY) * intpy
        
        if intpositive == 0 {
            randx *= -1
        }
        
        print("xx: \(randx) yy: \(randy)\n\n")
        
        currentLocation = CGPoint.init(x: randx, y: randy)
        
        GameScene.positionBar.run(SKAction.move(to: currentLocation, duration: 1))
        
        return currentLocation
    }
    
    static func increaseScore(){
        score += 1
        GameViewController.updateScore()
        //TODO: update score display
    }
    
    static func resetScore(){
        score = 0
    }
    
    static func getNewColor() -> UIColor{
        let white = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let owhite = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        var newColor = GameViewController.getPixelColorAtPoint(point: getNewLocation())
        while newColor == white || newColor == owhite || newColor == UIColor.black {
            newColor = GameViewController.getPixelColorAtPoint(point: getNewLocation())
            print("new color: \(newColor)")
            print("white: \(white)")
        }
        print("hello\n")
        return newColor
    }
    
    static func resetTimer(){
        
    }
    
    
    static func gotCorrectColor(){
        increaseScore()
        if (score % 5) == 0 {
            GameScene.changeGradients()
        }
        
        resetTimer()
        GameScene.setColor()
        
    }
}
