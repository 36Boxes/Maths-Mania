//
//  QuickFirePopUp.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit
import GameKit

class QuickFirePopUp: UIViewController, GKGameCenterControllerDelegate {
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var QFaced: UILabel!
    @IBOutlet weak var UserScore: UILabel!
    @IBOutlet weak var PrevioushighScore: UILabel!
    @IBOutlet weak var highscoreStr: UILabel!
    
    // Var for holding the users score
    
    var userScore:Int = 0
    
    // Var for holding the users high score
    
    var highScore:Int = 0
    
    // Var for holding the question the user faced
    
    var qFaced:String = " "
    
    // var for changing the text next to high score
    
    var highscoreSTR:String = ""
    
    // var for knowing which gamemode the user played
    
    var GameMode = String()
    
    // var for holding the Difficulty
    
    var Difficulty = String()
    
    //
    
    var scoreReporter = GKScore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserScore.text = String(userScore)
        PrevioushighScore.text = String(highScore)
        QFaced.text = qFaced
        highscoreStr.text = highscoreSTR
        saveHigh(number: highScore)
    }
    

    func saveHigh(number : Int){
        
        if GKLocalPlayer.local.isAuthenticated{
            if GameMode == "Plus"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAdditionHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAdditionHard")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAdditionHard")}
            }
            if GameMode == "Minus"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalSubtractionHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalSubtractionHard")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalSubtractionHard")}
            }
            if GameMode == "Divide"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalDivisionHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalDivisionHard")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalDivisionHard")}
            }
            if GameMode == "Multiply"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalMultiplicationHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalMultiplicationHard")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalMultiplicationHard")}
            }
            if GameMode == "All"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAllHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAllHard")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAllHard")}
            }
            scoreReporter.value = Int64(number)
            let ScoreArray : [GKScore] = [scoreReporter]
            GKScore.report(ScoreArray, withCompletionHandler: nil)

        }}
    
    @IBAction func playAgain(_ sender: UIButton) {
    }
    @IBAction func mainMenu(_ sender: UIButton) {
    }
    @IBAction func leaderboards(_ sender: UIButton) {
    }
}
