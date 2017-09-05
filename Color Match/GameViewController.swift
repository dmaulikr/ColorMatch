//
//  GameViewController.swift
//  Color Match
//
//  Created by Zach Johnson on 5/30/17.
//  Copyright © 2017 zsjohnson.me. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

// Extension of CALayer to get the color of specified point
// point1: location to find for color
// returns CGColor of specified color
extension CALayer {
    
    func colorOfPoint(point1:CGPoint) -> CGColor {
        
        var point = CGPoint.init(x: point1.x, y: point1.y)
        
        point.x = point1.x + GameViewController.theView!.bounds.maxX/2
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        
        self.render(in: context!)
        
        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
        
        let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)
        
        return color.cgColor
    }
}


extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}



extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
}

extension Dictionary {
    func getRandomItem() -> Element{
        let index: Int = Int(arc4random_uniform(UInt32(self.count)))
        let randomVal = Array(self)[index] // 123 or 234 or 345
        return randomVal
    }
}

class GameViewController: UIViewController {

    
    static var colorList: [String:UIColor] = [
        "purple":UIColor(red:0.63, green:0.36, blue:0.95, alpha:1.0),
        "blue":UIColor(red:0.36, green:0.43, blue:0.95, alpha:1.0),
        "pink":UIColor(red:0.95, green:0.36, blue:0.91, alpha:1.0),
        "red":UIColor(red:0.95, green:0.36, blue:0.38, alpha:1.0),
        "orange":UIColor(red:0.95, green:0.56, blue:0.36, alpha:1.0),
        "yellow":UIColor(red:0.95, green:0.92, blue:0.36, alpha:1.0),
        "green":UIColor(red:0.38, green:0.95, blue:0.36, alpha:1.0),
        "lblue":UIColor(red:0.36, green:0.92, blue:0.95, alpha:1.0)
    ]
    
    static var theView: UIView? = nil
    static var gradView: UIView? = nil
    static var gradient: CAGradientLayer? = nil
    static var score = UITextView.init()
    static var highScore = UITextView.init()
    static var progressBar = UIProgressView.init()
    
    static var rect: CGRect? = nil
    /*
    static func getColorAtPoint(location: CGPoint) -> UIColor {
        if theView != nil {
            let tmpImage = UIImage.init(view: theView!)
            return tmpImage.getPixelColor(pos: location)
        } else {
            return UIColor.black
        }
        
    }*/
    
    // Selects 2 new colors to create a new gradient
    // TODO: Make functional for 2x2 gradients
    static func getNewGradient(){
        
        var color1 = colorList.getRandomItem().value.cgColor
        var color2 = colorList.getRandomItem().value.cgColor
        
        while color1 == color2 {
            color1 = colorList.getRandomItem().value.cgColor
            color2 = colorList.getRandomItem().value.cgColor
        }
        
        gradient!.frame = rect!
        gradient!.colors = [color1, color2]
        gradient!.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        gradient!.frame = theView!.bounds
        
        gradView!.layer.insertSublayer(gradient!, at: 0)
        theView!.insertSubview(gradView!, at: 0)
    }
    
    
    // Gets the color of a pixel at a certain location
    // at point: CGPoint, location
    static func getPixelColor(at point:CGPoint) -> UIColor{
        
        
        /*
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        if theView != nil {
            theView!.layer.render(in: context!)
            let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0,
                                        green: CGFloat(pixel[1])/255.0,
                                        blue: CGFloat(pixel[2])/255.0,
                                        alpha: CGFloat(pixel[3])/255.0)
            
            pixel.deallocate(capacity: 4)
            return color
        } else {
            return UIColor.red
        }*/
        
        if theView != nil {
            return UIColor.init(cgColor: theView!.layer.colorOfPoint(point1: point))
        } else {
            return UIColor.black
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameViewController.theView = self.view
        
        GameViewController.gradView = UIView(frame: GameViewController.theView!.bounds)
        GameViewController.gradient = CAGradientLayer()
        GameViewController.rect = CGRect.init(x: Int(GameViewController.theView!.bounds.minX), y: Int(GameViewController.theView!.bounds.minY), width: Int(GameViewController.theView!.bounds.size.height), height: Int(GameViewController.theView!.bounds.size.width))
        
        GameViewController.getNewGradient()
        
        let view: SKView = SKView(frame: self.view.bounds)
        
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.backgroundColor = UIColor.clear
        
            view.showsFPS = true
            view.showsNodeCount = true
        self.view.addSubview(view)
        
        
        let frame = #imageLiteral(resourceName: "Frame")
        let frameView = UIImageView.init(image: frame)
        frameView.frame = self.view.bounds
        self.view.addSubview(frameView)
        
        
        
        let status = UITextView.init()
        status.text = "Color Match"
        GameViewController.score.text = "0"
        GameViewController.rect = CGRect.init(x: (Int(self.view.center.x)) - 55, y: 7, width: 110, height: 100)
        status.frame = GameViewController.rect!
        GameViewController.score.frame = CGRect.init(x: 10, y: 7, width: 50, height: 50)
        GameViewController.score.textColor = UIColor.black
        GameViewController.score.backgroundColor = UIColor.clear
        GameViewController.score.font = UIFont.init(name: "Avenir-Heavy", size: 16)
        status.textColor = UIColor.black
        status.backgroundColor = UIColor.clear
        
        GameViewController.highScore.text = "\(GameLogic.getHighScore(for: "highScoreNormal"))"
        GameViewController.highScore.frame = CGRect.init(x: (Int(self.view.bounds.maxX)) - 30, y: 7, width: 50, height: 50)
        GameViewController.highScore.textColor = UIColor.black
        GameViewController.highScore.backgroundColor = UIColor.clear
        GameViewController.highScore.font = UIFont.init(name: "Avenir-Heavy", size: 16)
        
        // Add progress bar
        GameViewController.progressBar.progressTintColor = UIColor.red
        GameViewController.progressBar.center = CGPoint.init(x: self.view.center.x, y: 10)
        GameViewController.progressBar.setProgress(0.9, animated: true)
        GameViewController.progressBar.frame = CGRect.init(x: 10, y: 36, width: self.view.frame.width - 20, height: 400)
        
        
        status.font = UIFont.init(name: "Avenir-Heavy", size: 16)
        
        self.view.addSubview(GameViewController.score)
        self.view.addSubview(GameViewController.highScore)
        self.view.addSubview(status)
        self.view.addSubview(GameViewController.progressBar)
        //let verticalCenter = NSLayoutConstraint.init(item: status, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        //self.view.addConstraint(verticalCenter)
        
    }
    
    
    // Updates the score
    // Compares if the score is larger than the saved high score. Replaces it if so
    static func updateScore(){
        score.text = "\(GameLogic.score)"
        if GameLogic.score > GameLogic.highScore {
            GameLogic.setHighScore(for: "highScoreNormal")
            highScore.text = "\(GameLogic.highScore)"
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
