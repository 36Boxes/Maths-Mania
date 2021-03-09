//
//  LeaderboardDifficulty.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class LeaderboardDifficulty: UIViewController {
    
    var GameMode = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {}
        
        // Naming our objects
        
        let AdditionHard = UserDefaults.standard.integer(forKey : "highscorePlusHard")
        let AdditionMedium = UserDefaults.standard.integer(forKey : "highscorePlusMedium")
        let AdditionEasy = UserDefaults.standard.integer(forKey : "highscorePlusEasy")
        
        let SubtractionHard = UserDefaults.standard.integer(forKey : "highscoreMinusHard")
        let SubtractionMedium = UserDefaults.standard.integer(forKey : "highscoreMinusMedium")
        let SubtractionEasy = UserDefaults.standard.integer(forKey : "highscoreMinusEasy")
        
        let DivisionHard = UserDefaults.standard.integer(forKey : "highscoreDivideHard")
        let DivisionMedium = UserDefaults.standard.integer(forKey : "highscoreDivideMedium")
        let DivisionEasy = UserDefaults.standard.integer(forKey : "highscoreDivideEasy")
        
        let MultiplicationHard = UserDefaults.standard.integer(forKey : "highscoreMultiplyHard")
        let MultiplicationMedium = UserDefaults.standard.integer(forKey : "highscoreMultiplyMedium")
        let MultiplicationEasy = UserDefaults.standard.integer(forKey : "highscoreMultiplyEasy")
        
        
        if GameMode == "Plus"{
            if AdditionHard == 0 {
                HardButton.isEnabled = false
                HardButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if AdditionMedium == 0 {
                MediumButton.isEnabled = false
                MediumButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if AdditionEasy == 0 {
                EasyButton.isEnabled = false
                EasyButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
        }
        if GameMode == "Minus"{
            if SubtractionHard == 0 {
                HardButton.isEnabled = false
                HardButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if SubtractionMedium == 0 {
                MediumButton.isEnabled = false
                MediumButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if SubtractionEasy == 0 {
                EasyButton.isEnabled = false
                EasyButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
        }
        if GameMode == "Divide"{
            if DivisionHard == 0 {
                HardButton.isEnabled = false
                HardButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if DivisionMedium == 0 {
                MediumButton.isEnabled = false
                MediumButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if DivisionEasy == 0 {
                EasyButton.isEnabled = false
                EasyButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
        }
        if GameMode == "Multiply"{
            if MultiplicationHard == 0 {
                HardButton.isEnabled = false
                HardButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if MultiplicationMedium == 0 {
                MediumButton.isEnabled = false
                MediumButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
            if MultiplicationEasy == 0 {
                EasyButton.isEnabled = false
                EasyButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
            }
        }
    }
    @IBOutlet weak var HardButton: UIButton!
    @IBOutlet weak var MediumButton: UIButton!
    @IBOutlet weak var EasyButton: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "hard"{
            if GameMode == "Plus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAdditionHard"
            }
            if GameMode == "Minus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalSubtractionHard"
            }
            if GameMode == "Divide"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalDivisionHard"
            }
            if GameMode == "Multiply"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalMultiplicationHard"
            }
            if GameMode == "All"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAllHard"
            }
        }
        if segue.identifier == "medium"{
            if GameMode == "Plus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAdditionMedium"
            }
            if GameMode == "Minus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalSubtractionMedium"
            }
            if GameMode == "Divide"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalDivisionMedium"
            }
            if GameMode == "Multiply"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalMultiplicationMedium"
            }
            if GameMode == "All"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAllMedium"
            }
        }
        if segue.identifier == "easy"{
            if GameMode == "Plus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAdditionEasy"
            }
            if GameMode == "Minus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalSubtractionEasy"
            }
            if GameMode == "Divide"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalDivisionEasy"
            }
            if GameMode == "Multiply"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalMultiplicationEasy"
            }
            if GameMode == "All"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAllEasy"
            }
        }
    }

}
