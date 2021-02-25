//
//  popupViewController.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 08/02/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit
import GameKit

class popupViewController: UIViewController, GKGameCenterControllerDelegate{
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    // Var for holding the users score
    var userScore:Int = 0
    
    // Var for holding the users high score
    var highScore:Int = 0
    
    // Var for holding the question the user faced
    var QFaced:String = " "
    
    // var for changing the text next to high score
    var high:String = ""
    
    @IBAction func mainMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "mainmenu", sender: nil)
    }
    @IBAction func PlayAgain(_ sender: Any) {
        performSegue(withIdentifier: "playagain", sender: nil)
    }
    @IBAction func BacktoLeaderboards(_ sender: Any) {
        performSegue(withIdentifier: "showleaderboards", sender: nil)
    }
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var highscored: UILabel!
    @IBOutlet weak var mostHigh: UILabel!
    @IBOutlet weak var qFaced: UILabel!
    @IBAction func soloMode(_ sender: Any) {
    }
    override func viewDidLoad() {
        score.text = String(userScore)
        highscored.text = String(highScore)
        qFaced.text = QFaced
        mostHigh.text = high
        saveHigh(number: highScore)
        super.viewDidLoad()
    }
    
    func saveHigh(number : Int){
        if GKLocalPlayer.local.isAuthenticated{
            let scoreReporter = GKScore(leaderboardIdentifier: "Scores")
            scoreReporter.value = Int64(number)
            let ScoreArray : [GKScore] = [scoreReporter]
            GKScore.report(ScoreArray, withCompletionHandler: nil)

        }}

}
