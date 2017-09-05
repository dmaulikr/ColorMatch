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
    static var timer = Timer()
    
    static var currentLocation: CGPoint = CGPoint.init(x: 0, y: 0)
    static var colorLocation: CGPoint = CGPoint(x:0, y:0)
    
    static var highScore: Int = UserDefaults().integer(forKey: "highScoreNormal")
    
    static func randomNumber(MIN: Int, MAX: Int)-> Int{
        return Int(arc4random_uniform(UInt32(MAX)) + UInt32(MIN));
    }
    
    static func getNewLocation() -> CGPoint {
    
        let intpx:Double = Double(randomNumber(MIN: 0, MAX: 45)) / 100.0
        let intpy:Double = Double(randomNumber(MIN: 0, MAX: 95)) / 100.0
        let intpositive = randomNumber(MIN: 0, MAX: 2)
        
        print("px: \(intpx) py: \(intpy)\n\n")
        
        var randx: Double = Double(GameViewController.theView!.bounds.maxX) * intpx
        let randy: Double = Double(GameViewController.theView!.bounds.maxY) * intpy
        
        if intpositive == 0 {
            randx *= -1
        }
        
        print("xx: \(randx) yy: \(randy)\n\n")
        
        if abs(randx - Double(currentLocation.x)) < 100 {
            colorLocation = getNewLocation()
        } else {
            colorLocation = CGPoint.init(x: randx, y: randy)
            currentLocation = CGPoint.init(x: randx * 2.1, y: randy)
        }
        
        
        // Test bar for location
        //GameScene.positionBar.run(SKAction.move(to: currentLocation, duration: 1))
        
        return colorLocation
    }
    
    static func increaseScore(){
        score += 1
        GameViewController.updateScore()
        //TODO: update score display
    }
    
    
    static func startTimer(for time: Int){
        
        
    }
    
    static func resetScore(){
        score = 0
    }
    
    static func getNewColor() -> UIColor{
        let white = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let owhite = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        var newColor = GameViewController.getPixelColor(at: getNewLocation())
        while newColor == white || newColor == owhite || newColor == UIColor.black {
            newColor = GameViewController.getPixelColor(at: getNewLocation())
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
        } else {
            GameScene.setColor()
        }
        
        resetTimer()
        
        
    }
    
    /*
     Get the high score for the specified gamemode.
     Possible gamemodes: gameModeNormal, gameModeSpeedy, gameModeExpert
     */
    static func getHighScore(for gameModeKey: String) -> Int{
        return GameLogic.highScore
    }
    
    /*
     Save the current score as the high score in the user defaults
     Requires the necessary game mode key in order to update the proper gamemode's high score
    */
    static func setHighScore(for gameModeKey: String) {
        UserDefaults.standard.set(GameLogic.score, forKey: gameModeKey)
        highScore += 1
    }
    
    /*
     Reset the high score to 0
     Requires the necessary game mode key in order to update the proper gamemode's high score
     */
    static func resetHighScore(for gameModeKey: String) {
        let zeroScore = 0
        UserDefaults.standard.set(zeroScore, forKey: gameModeKey)
    }
}
