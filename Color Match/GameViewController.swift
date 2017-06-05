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

class GameViewController: UIViewController {

    static var theView: UIView? = nil
    
    /*
    static func getColorAtPoint(location: CGPoint) -> UIColor {
        if theView != nil {
            let tmpImage = UIImage.init(view: theView!)
            return tmpImage.getPixelColor(pos: location)
        } else {
            return UIColor.black
        }
        
    }*/
    
    static func getPixelColorAtPoint(point:CGPoint) -> UIColor{
        
        
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
        
        let gradView = UIView(frame: self.view.bounds)
        let gradient = CAGradientLayer()
        
        var rect = CGRect.init(x: Int(self.view.bounds.minX), y: Int(self.view.bounds.minY), width: Int(self.view.bounds.size.height), height: Int(self.view.bounds.size.width))
        
        gradient.frame = rect
        gradient.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        gradient.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        gradient.frame = self.view.bounds
        
        gradView.layer.insertSublayer(gradient, at: 0)
        self.view.addSubview(gradView)
        
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
        rect = CGRect.init(x: (Int(self.view.center.x)) - 55, y: 7, width: 110, height: 100)
        status.frame = rect
        status.textColor = UIColor.black
        status.backgroundColor = UIColor.clear
        
        status.font = UIFont.init(name: "Avenir-Heavy", size: 16)
        
        self.view.addSubview(status)
        let verticalCenter = NSLayoutConstraint.init(item: status, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(verticalCenter)
        
    }

    override var shouldAutorotate: Bool {
        return true
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
