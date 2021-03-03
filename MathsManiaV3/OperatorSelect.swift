//
//  OperatorSelect.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 03/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class OperatorSelect: UIViewController {
    @IBAction func Plus(_ sender: Any) {
        performSegue(withIdentifier: "gotoquickfireplus", sender: nil)
    }
    @IBAction func Minus(_ sender: Any) {
        performSegue(withIdentifier: "quickfireminus", sender: nil)
    }
    @IBAction func Divide(_ sender: Any) {
        performSegue(withIdentifier: "quickfiredivide", sender: nil)
    }
    @IBAction func Multiply(_ sender: Any) {
        performSegue(withIdentifier: "quickfiremultiply", sender: nil)
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
    }
    
    // We want to pass what gamemode was selected so we filter it out via the segue
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "gotoquickfireplus"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.GameMode = "Plus"
        }
        if segue.identifier == "quickfireminus"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.GameMode = "Minus"
        }
        if segue.identifier == "quickfiredivide"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.GameMode = "Divide"
        }
        if segue.identifier == "quickfiremultiply"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.GameMode = "Multiply"
        }
        if segue.identifier == "quickfireall"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.GameMode = "All"
        }
    }
    



}
