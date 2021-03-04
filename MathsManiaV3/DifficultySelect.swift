//
//  DifficultySelect.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class DifficultySelect: UIViewController {
    @IBAction func Hardmode(_ sender: Any) {
        performSegue(withIdentifier: "hardmode", sender: nil)
    }
    @IBAction func MediumMode(_ sender: Any) {
        performSegue(withIdentifier: "mediummode", sender: nil)
    }
    @IBAction func EasyMode(_ sender: Any) {
        performSegue(withIdentifier: "easymode", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LeaderboardBackground copy")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "hardmode"{
            let destination = segue.destination as! OperatorSelect
            destination.Difficulty = "Hard"
        }
        if segue.identifier == "mediummode"{
            let destination = segue.destination as! OperatorSelect
            destination.Difficulty = "Medium"
        }
        if segue.identifier == "easymode"{
            let destination = segue.destination as! OperatorSelect
            destination.Difficulty = "Easy"
        }
    }
    
}
