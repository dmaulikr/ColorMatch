//
//  StartViewController.swift
//  Color Match
//
//  Created by Zach Johnson on 7/18/17.
//  Copyright © 2017 zsjohnson.me. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selector: UIPickerView!
    static var theView: UIView? = nil
    static var gradView: UIView? = nil
    static var gradient: CAGradientLayer? = nil
    static var score = UITextView.init()
    let gameModes: [String] = ["Normal", "Speedy","Expert"]
    
    static var rect: CGRect? = nil
    
    @IBAction func startPressed(_ sender: AnyObject) {
        
        if selector.selectedRow(inComponent: 0) == 0 {
            performSegue(withIdentifier: "normal", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StartViewController.theView = self.view
        
        StartViewController.gradView = UIView(frame: StartViewController.theView!.bounds)
        StartViewController.gradient = CAGradientLayer()
        StartViewController.rect = CGRect.init(x: Int(StartViewController.theView!.bounds.minX), y: Int(StartViewController.theView!.bounds.minY), width: Int(StartViewController.theView!.bounds.size.height), height: Int(StartViewController.theView!.bounds.size.width))
        
        StartViewController.getNewGradient()

        
        self.selector.delegate = self
        self.selector.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = gameModes[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameModes.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameModes[row]
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /*
     static func getColorAtPoint(location: CGPoint) -> UIColor {
     if theView != nil {
     let tmpImage = UIImage.init(view: theView!)
     return tmpImage.getPixelColor(pos: location)
     } else {
     return UIColor.black
     }
     
     }*/
    
    static func getNewGradient(){
        
        var color1 = GameViewController.colorList.getRandomItem().value.cgColor
        var color2 = GameViewController.colorList.getRandomItem().value.cgColor
        
        while color1 == color2 {
            color1 = GameViewController.colorList.getRandomItem().value.cgColor
            color2 = GameViewController.colorList.getRandomItem().value.cgColor
        }
        
        gradient!.frame = rect!
        gradient!.colors = [color1, color2]
        gradient!.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        gradient!.frame = theView!.bounds
        
        gradView!.layer.insertSublayer(gradient!, at: 0)
        theView!.insertSubview(gradView!, at: 0)
    }

}
