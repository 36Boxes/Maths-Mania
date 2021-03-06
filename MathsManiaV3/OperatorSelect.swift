//
//  OperatorSelect.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 03/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class OperatorSelect: UIViewController {
    
    @IBOutlet weak var GoBackButton: UIButton!
    
    var Difficulty = String()
    
    @IBAction func Plus(_ sender: Any) {
        GoBackButton.isHidden = true
        let Popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "normalpopup") as! DifficultySelect
        Popup.GameMode = "Plus"
        self.addChild(Popup)
        // ensuring the popup frame is the same as the main view frame
        Popup.view.frame = self.view.frame
        //adding the popup to the view
        self.view.addSubview(Popup.view)
        Popup.didMove(toParent: self)
        
    }
    @IBAction func Minus(_ sender: Any) {
        GoBackButton.isHidden = true
        let Popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "normalpopup") as! DifficultySelect
        Popup.GameMode = "Minus"
        self.addChild(Popup)
        // ensuring the popup frame is the same as the main view frame
        Popup.view.frame = self.view.frame
        //adding the popup to the view
        self.view.addSubview(Popup.view)
        Popup.didMove(toParent: self)
    }
    @IBAction func Divide(_ sender: Any) {
        GoBackButton.isHidden = true
        let Popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "normalpopup") as! DifficultySelect
        Popup.GameMode = "Divide"
        self.addChild(Popup)
        // ensuring the popup frame is the same as the main view frame
        Popup.view.frame = self.view.frame
        //adding the popup to the view
        self.view.addSubview(Popup.view)
        Popup.didMove(toParent: self)
    
    }
    @IBAction func Multiply(_ sender: Any) {
        GoBackButton.isHidden = true
        let Popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "normalpopup") as! DifficultySelect
        Popup.GameMode = "Multiply"
        self.addChild(Popup)
        // ensuring the popup frame is the same as the main view frame
        Popup.view.frame = self.view.frame
        //adding the popup to the view
        self.view.addSubview(Popup.view)
        Popup.didMove(toParent: self)
    
    }
    @IBAction func All(_ sender: Any) {
        performSegue(withIdentifier: "quickfireall", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding the background to the application
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Credits")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    // We want to pass what gamemode was selected so we filter it out via the segue
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "gotoquickfireplus"{
            let destination = segue.destination as! DifficultySelect
            destination.GameMode = "Plus"
        }
        if segue.identifier == "quickfireminus"{
            let destination = segue.destination as! DifficultySelect
            destination.GameMode = "Minus"
        }
        if segue.identifier == "quickfiredivide"{
            let destination = segue.destination as! DifficultySelect
            destination.GameMode = "Divide"
        }
        if segue.identifier == "quickfiremultiply"{
            let destination = segue.destination as! DifficultySelect
            destination.GameMode = "Multiply"
        }
        if segue.identifier == "quickfireall"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.GameMode = "All"
            destination.Difficulty = "Insane"
        }
    }
    



}
