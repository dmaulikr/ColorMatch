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
    
        let intpx = randomNumber(MIN: 0, MAX: 101)
        let intpy = randomNumber(MIN: 0, MAX: 101)
        
        print("px: \(intpx) py: \(intpy)\n\n")
        
        let randx: Int = Int(GameViewController.theView!.frame.maxX) * intpx / 100
        let randy: Int = Int(GameViewController.theView!.frame.maxY) * intpy / 100
        
        print("xx: \(randx) yy: \(randy)\n\n")
        
        currentLocation = CGPoint.init(x: 49, y: 300)
        
        return currentLocation
    }
    
    static func increaseScore(){
        score += 1
    }
    
    static func resetScore(){
        score = 0
    }
    
    static func getNewColor() -> UIColor{
        
        let newColor = GameViewController.getPixelColorAtPoint(point: getNewLocation())
        print("new color: \(newColor)")
        return newColor
    }
}
