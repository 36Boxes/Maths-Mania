//
//  QuickFirePopUp.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit
import GameKit
import GoogleMobileAds

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
    
    private let banner: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-6767422419955516/1145929040"
        banner.load(GADRequest())
        banner.backgroundColor = UIColor.lightGray
        return banner
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        UserScore.text = String(userScore)
        PrevioushighScore.text = String(highScore)
        QFaced.text = qFaced
        highscoreStr.text = highscoreSTR
        saveHigh(number: highScore)
        banner.rootViewController = self
        view.addSubview(banner)
    }
    

    func saveHigh(number : Int){
        
        if GKLocalPlayer.local.isAuthenticated{
            if GameMode == "Plus"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAdditionHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAdditionMedium")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAdditionEasy")}
            }
            if GameMode == "Minus"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalSubtractionHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalSubtractionMedium")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalSubtractionEasy")}
            }
            if GameMode == "Divide"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalDivisionHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalDivisionMedium")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalDivisionEasy")}
            }
            if GameMode == "Multiply"{
                if Difficulty == "Hard"{scoreReporter = GKScore(leaderboardIdentifier: "NormalMultiplicationHard")}
                if Difficulty == "Medium"{scoreReporter = GKScore(leaderboardIdentifier: "NormalMultiplicationMedium")}
                if Difficulty == "Easy"{scoreReporter = GKScore(leaderboardIdentifier: "NormalMultiplicationEasy")}
            }
            if GameMode == "All"{
                if Difficulty == "Insane"{scoreReporter = GKScore(leaderboardIdentifier: "NormalAllHard")}
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x:0, y: view.frame.size.height-50, width: view.frame.size.width, height: 50)
    }
}
