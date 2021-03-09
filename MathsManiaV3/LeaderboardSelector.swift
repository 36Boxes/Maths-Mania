//
//  LeaderboardSelector.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class LeaderboardSelector: UIViewController {

    @IBOutlet weak var GoBack: UIButton!
    @IBOutlet weak var NormalAddition: UIButton!
    @IBOutlet weak var NormalSubtraction: UIButton!
    @IBOutlet weak var NormalMultiplication: UIButton!
    @IBOutlet weak var NormalDivision: UIButton!
    @IBOutlet weak var Insane: UIButton!
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

        // Check if the total of all the highscores is 0 as then the user doesnt have a score on the leaderboard so shouldnt be able to continue
        
        if UserDefaults.standard.integer(forKey : "highscorePlusHard") +  UserDefaults.standard.integer(forKey : "highscorePlusMedium") + UserDefaults.standard.integer(forKey : "highscorePlusEasy") == 0{
            NormalAddition.isEnabled = false
            NormalAddition.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        }
        if UserDefaults.standard.integer(forKey : "highscoreMinusHard") +  UserDefaults.standard.integer(forKey : "highscoreMinusMedium") + UserDefaults.standard.integer(forKey : "highscoreMinusEasy") == 0{
            NormalSubtraction.isEnabled = false
            NormalSubtraction.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        }
        if UserDefaults.standard.integer(forKey : "highscoreMultiplyHard") +  UserDefaults.standard.integer(forKey : "highscoreMultiplyMedium") + UserDefaults.standard.integer(forKey : "highscoreMultiplyEasy") == 0{
            NormalMultiplication.isEnabled = false
            NormalMultiplication.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        }
        if UserDefaults.standard.integer(forKey : "highscoreDivideHard") +  UserDefaults.standard.integer(forKey : "highscoreDivideMedium") + UserDefaults.standard.integer(forKey : "highscoreDivideEasy") == 0{
            NormalDivision.isEnabled = false
            NormalDivision.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        }
        if UserDefaults.standard.integer(forKey : "highscoreAllHard")  == 0{
            Insane.isEnabled = false
            Insane.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        }
    }
    
    @IBAction func Addition(_ sender: UIButton) {
        GoBack.isHidden = true
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leaderboarddiff") as! LeaderboardDifficulty
        popup.GameMode = "Plus"
        self.addChild(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParent: self)
    }
    
    @IBAction func Subtraction(_ sender: UIButton) {
        GoBack.isHidden = true
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leaderboarddiff") as! LeaderboardDifficulty
        popup.GameMode = "Minus"
        self.addChild(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParent: self)
    }
    
    @IBAction func Multiplication(_ sender: Any) {
        GoBack.isHidden = true
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leaderboarddiff") as! LeaderboardDifficulty
        popup.GameMode = "Multiply"
        self.addChild(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParent: self)
    }
    
    @IBAction func Division(_ sender: Any) {
        GoBack.isHidden = true
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leaderboarddiff") as! LeaderboardDifficulty
        popup.GameMode = "Divide"
        self.addChild(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParent: self)
    }
    
    
    @IBAction func ResetLocation(_ sender: Any) {
        let Locationpopup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "locationpopup") as! LocationPopupViewController

        self.addChild(Locationpopup)
        // ensuring the popup frame is the same as the main view frame
        Locationpopup.view.frame = self.view.frame
        //adding the popup to the view
        self.view.addSubview(Locationpopup.view)
        Locationpopup.didMove(toParent: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "endless"{
            let destination = segue.destination as! LeaderboardViewController
            destination.LeaderboardIdentifier = "Scores"
        }

        if segue.identifier == "all"{
            let destination = segue.destination as! LeaderboardViewController
            destination.LeaderboardIdentifier = "NormalAllHard"
        }
    }

}
