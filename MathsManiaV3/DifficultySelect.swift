//
//  DifficultySelect.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class DifficultySelect: UIViewController {
    
    var GameMode = String()
    
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
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "hardmode"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.Difficulty = "Hard"
            destination.GameMode = GameMode
        }
        if segue.identifier == "mediummode"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.Difficulty = "Medium"
            destination.GameMode = GameMode
        }
        if segue.identifier == "easymode"{
            let destination = segue.destination as! QuickFireGameViewController
            destination.Difficulty = "Easy"
            destination.GameMode = GameMode
        }
    }
    
}
