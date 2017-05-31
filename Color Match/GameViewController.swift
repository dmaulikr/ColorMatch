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

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradView = UIView(frame: self.view.bounds)
        let gradient = CAGradientLayer()
        
        let rect = CGRect.init(x: Int(self.view.bounds.minX), y: Int(self.view.bounds.minY), width: Int(self.view.bounds.size.height), height: Int(self.view.bounds.size.width))
        
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
        var frameView = UIImageView.init(image: frame)
        frameView.frame = self.view.bounds
        self.view.addSubview(frameView)
        
        
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
