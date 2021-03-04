//
//  LeaderboardViewController.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 16/02/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit
import GameKit

class LeaderboardViewController: UIViewController, GKGameCenterControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var Local = true
    
    var LeaderboardIdentifier = String()
    
    @IBOutlet weak var ReloadButton: UIButton!
    @IBOutlet weak var EntireButton: UIButton!
    // The Dictionary that holds our leaderboard info
    
    var Group_Loc_Scores = [["score" : "Score", "location" : "UserLocation","player_name" : "Player Name", "player_ID" : String(), "rank" : "rank"]]
    
    // The elegible counties for localised leaderboards
    
    let counties : [String] = ["Bath and North East Somerset", "Bedfordshire", "Berkshire", "Bristol", "Buckinghamshire", "Cambridgeshire", "Cheshire","Cornwall", "County Durham", "Cumbria","Derbyshire", "Devon", "Dorset","East Riding of Yorkshire", "East Sussex", "Essex","Gloucestershire", "Greater London", "Greater Manchester","Hampshire", "Herefordshire", "Hertfordshire","Isle of Wight", "Isles of Scilly", "Kent","Lancashire", "Leicestershire", "Lincolnshire","Merseyside", "Norfolk", "North Somerset","North Yorkshire", "Northamptonshire", "Northumberland","Nottinghamshire", "Oxfordshire", "Rutland","Shropshire", "Somerset", "South Gloucestershire","South Yorkshire", "Staffordshire", "Suffolk","Surrey", "Tyne & Wear", "Warwickshire","West Midlands" ,"West Sussex", "West Yorkshire","Wiltshire", "Worcestershire", "ROTW"]
    
    // Passing the length of the data to the table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Group_Loc_Scores.count
    }
    
    // Updating table values
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2{
            if Local == true{
                let cell = tableView.dequeueReusableCell(withIdentifier: "breakcell", for: indexPath) as!
                    LeaderBoardBreakTableViewCell
                cell.Label.text = "local Leaderboard"
                return cell
            }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "breakcell", for: indexPath) as!
                LeaderBoardBreakTableViewCell
                cell.Label.text = "Entire Leaderboard"
            return cell
            }
        }
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as!
                TableViewCell
            let group_scores = Group_Loc_Scores[indexPath.row]
            let scor = group_scores["score"]!
            let locatio = group_scores["location"]!
            let player_nam = group_scores["player_name"]!
            let player_rank = group_scores["rank"]!
            
            let score = String(scor)
            let loca = String(locatio)
            let player_name = String(player_nam)
            
            let loc = Int(loca)
            var text_to_show = "Location"
            
            for (index, county) in counties.enumerated(){
                if index == loc{
                    text_to_show = counties[index]
                }
            }
            cell.PlayerRank.text = player_rank
            cell.PlayerName.text = player_nam
            cell.PlayerArea.text = text_to_show
            cell.PlayerScore.text = score
            return cell
        }
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as!
                TableViewCell
            let group_scores = Group_Loc_Scores[indexPath.row]
            let scor = group_scores["score"]!
            let locatio = group_scores["location"]!
            let player_nam = group_scores["player_name"]!
            let player_rank = group_scores["rank"]!
            
            let score = String(scor)
            let loca = String(locatio)
            let player_name = String(player_nam)
            
            let loc = Int(loca)
            var text_to_show = "Location"
            
            for (index, county) in counties.enumerated(){
                if index == loc{
                    text_to_show = counties[index]
                }
            }
            cell.PlayerRank.text = player_rank
            cell.PlayerName.text = player_nam
            cell.PlayerArea.text = text_to_show
            cell.PlayerScore.text = score
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as!
            TableViewCell
        let group_scores = Group_Loc_Scores[indexPath.row]
        let scor = group_scores["score"]!
        let locatio = group_scores["location"]!
        let player_nam = group_scores["player_name"]!
        let player_rank = group_scores["rank"]!
        
        let score = String(scor)
        let loca = String(locatio)
        let player_name = String(player_nam)
        
        let loc = Int(loca)
        var text_to_show = "Location"
        
        for (index, county) in counties.enumerated(){
            if index == loc{
                text_to_show = counties[index]
            }
        }
        var rank = indexPath.row
        // we need to minus 2 as index starts at when the index number is 3
        
        rank = rank - 2
        let pop = String(rank)
        
        
        cell.PlayerRank.text = pop
        cell.PlayerName.text = player_nam
        cell.PlayerArea.text = text_to_show
        cell.PlayerScore.text = score
        return cell
        
    }
    

    
    var highScore:Int = 0
    var highScorePlusEasy:Int = 0
    var highScorePlusMedium:Int = 0
    var highScorePlusHard:Int = 0
    var highScoreMinusEasy:Int = 0
    var highScoreMinusMedium:Int = 0
    var highScoreMinusHard:Int = 0
    var highScoreDivideEasy:Int = 0
    var highScoreDivideMedium:Int = 0
    var highScoreDivideHard:Int = 0
    var highScoreMultiplyEasy:Int = 0
    var highScoreMultiplyMedium:Int = 0
    var highScoreMultiplyHard:Int = 0
    var highScoreAllEasy:Int = 0
    var highScoreAllMedium:Int = 0
    var highScoreAllHard:Int = 0

    @IBAction func ShowEntireLeaderboard(_ sender: Any) {
        Local = false
        load_full_leaders()
        EntireButton.isEnabled = false
        EntireButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        ReloadButton.isEnabled = true
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func showlead(_ sender: Any) {
        Local = true
        load_leaders()
        ReloadButton.isEnabled = false
        ReloadButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        EntireButton.isEnabled = true
    }
    @IBAction func GoBackHome(_ sender: Any) {performSegue(withIdentifier: "gobacktoselector", sender: nil)}
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        let nib2 = UINib(nibName: "LeaderBoardBreakTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.register(nib2, forCellReuseIdentifier: "breakcell")
        tableView.delegate = self
        tableView.dataSource = self
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Credits")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        authPlayer()
        load_leaders()
        ReloadButton.isEnabled = false
        ReloadButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        EntireButton.isEnabled = false
        EntireButton.setTitleColor(UIColor.lightGray, for: UIControl.State.disabled)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        


    }
    
    func load_leaders(){
        Group_Loc_Scores.removeAll()
        Group_Loc_Scores = [["score" : "Score", "location" : "UserLocation","player_name" : "Player Name", "player_ID" : String(), "rank" : "rank"]]
        var UserLocation = Int64()
        let Locations : GKLeaderboard = GKLeaderboard()
        Locations.timeScope = .allTime
        Locations.identifier = "Locations"
        let Scores : GKLeaderboard = GKLeaderboard()
        Scores.timeScope = .allTime
        Scores.identifier = LeaderboardIdentifier
        Scores.loadScores { scores, error in
            guard let scores = scores else {return}
        // load all the leaderboard scores and check to see if the user has set a locationID before the view loads
        Locations.loadScores { locats, error in
            
            // If this value is nil we know the user hasnt set a location so we need to prompt them to do so
            
            if Locations.localPlayerScore?.value == nil{
                let Locationpopup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "locationpopup") as! LocationPopupViewController

                self.addChild(Locationpopup)
                // ensuring the popup frame is the same as the main view frame
                Locationpopup.view.frame = self.view.frame
                //adding the popup to the view
                self.view.addSubview(Locationpopup.view)
                Locationpopup.didMove(toParent: self)
            }else{
                
                // If this is nil we know the user is yet to submit a score so we need to prompt them to do so
                
                if Scores.localPlayerScore?.value == nil{
                    let NoScorepopup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "noscorepopup") as! NoScorePopupViewController
                    self.addChild(NoScorepopup)
                    // ensuring the popup frame is the same as the main view frame
                    NoScorepopup.view.frame = self.view.frame
                    //adding the popup to the view
                    self.view.addSubview(NoScorepopup.view)
                    NoScorepopup.didMove(toParent: self)
                }else{
                    
                    // Add the local players score so we show that at the top
                    
                    let Group_toAddto_Loc_Scores = [["score" : String(Scores.localPlayerScore!.value), "location" : String(Locations.localPlayerScore!.value),"player_name" : String((Scores.localPlayerScore?.player.alias)!), "player_ID" : String((Scores.localPlayerScore?.player.playerID)!),
                                                     "rank" : String(Scores.localPlayerScore!.rank)
                    ]]
                    
                    UserLocation = Locations.localPlayerScore!.value
                    
                    // We add this as we need a blank in the data to workaround having a blank row in the table view
                    
                    let Extra_Addition = [["score": " ",
                                           "location": " ",
                                           "player_name" : " ",
                                           "player_ID" : " ",
                                           "rank" : " "]]
                    
            self.Group_Loc_Scores.append(contentsOf: Group_toAddto_Loc_Scores)
            self.Group_Loc_Scores.append(contentsOf: Extra_Addition)
                
                
            guard let locats = locats else {return}
            for score in scores{
                for location in locats{
                    // Check to make sure we have the same players location score and the actual score
                    if location.player.playerID == score.player.playerID{
                        //Check to make sure the player in questions location is the same as the users location
                        if location.value == UserLocation{
                            let group = ["score" : String(score.value), "location" : String(location.value),"player_name" : String(score.player.alias), "player_ID" : String(score.player.playerID), "rank" : String(score.rank)]
                        self.Group_Loc_Scores.append(group)
                        }
                    }
                    }
                    }
                    self.tableView.reloadData()
                    self.ReloadButton.isEnabled = true
                    self.EntireButton.isEnabled = true
                }}
        }}
    }
    
    func authPlayer(){
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = {
            (view, Error) in
            
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            }
            else {
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
        
    }
    
    func showLeader(){
        
        // This code gets the active view controller so we can post the game center leaderboard
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                let gcvc = GKGameCenterViewController()
                gcvc.gameCenterDelegate = self
                topController.present(gcvc, animated: true, completion: nil)
            }
        }

    }
    
    func load_full_leaders(){
        Group_Loc_Scores.removeAll()
        Group_Loc_Scores = [["score" : "Score", "location" : "UserLocation","player_name" : "Player Name", "player_ID" : String(), "rank" : "rank"]]
        let Locations : GKLeaderboard = GKLeaderboard()
        Locations.timeScope = .allTime
        Locations.identifier = "Locations"
        let Scores : GKLeaderboard = GKLeaderboard()
        Scores.timeScope = .allTime
        Scores.identifier = LeaderboardIdentifier
        Scores.loadScores { scores, error in
            guard let scores = scores else {return}
        // load all the leaderboard scores and check to see if the user has set a locationID before the view loads
        Locations.loadScores { locats, error in
            
            // If this value is nil we know the user hasnt set a location so we need to prompt them to do so
            
            if Locations.localPlayerScore?.value == nil{
                let Locationpopup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "locationpopup") as! LocationPopupViewController

                self.addChild(Locationpopup)
                // ensuring the popup frame is the same as the main view frame
                Locationpopup.view.frame = self.view.frame
                //adding the popup to the view
                self.view.addSubview(Locationpopup.view)
                Locationpopup.didMove(toParent: self)
            }else{
                
                // If this is nil we know the user is yet to submit a score so we need to prompt them to do so
                
                if Scores.localPlayerScore?.value == nil{
                    let NoScorepopup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "noscorepopup") as! NoScorePopupViewController
                    self.addChild(NoScorepopup)
                    // ensuring the popup frame is the same as the main view frame
                    NoScorepopup.view.frame = self.view.frame
                    //adding the popup to the view
                    self.view.addSubview(NoScorepopup.view)
                    NoScorepopup.didMove(toParent: self)
                }else{
                    
                    // Add the local players score so we show that at the top
                    
                    let Group_toAddto_Loc_Scores = [["score" : String(Scores.localPlayerScore!.value), "location" : String(Locations.localPlayerScore!.value),"player_name" : String((Scores.localPlayerScore?.player.alias)!), "player_ID" : String((Scores.localPlayerScore?.player.playerID)!),
                                                     "rank" : String(Scores.localPlayerScore!.rank)
                    ]]
                    
                    // We add this as we need a blank in the data to workaround having a blank row in the table view
                    
                    let Extra_Addition = [["score": " ",
                                           "location": " ",
                                           "player_name" : " ",
                                           "player_ID" : " ",
                                           "rank" : " "]]
                    
            self.Group_Loc_Scores.append(contentsOf: Group_toAddto_Loc_Scores)
            self.Group_Loc_Scores.append(contentsOf: Extra_Addition)
                
                
            guard let locats = locats else {return}
            for score in scores{
                for location in locats{
                    // Check to make sure we have the same players location score and the actual score
                    if location.player.playerID == score.player.playerID{
                        //Check to make sure the player in questions location is the same as the users location
                            let group = ["score" : String(score.value), "location" : String(location.value),"player_name" : String(score.player.alias), "player_ID" : String(score.player.playerID), "rank" : String(score.rank)]
                        self.Group_Loc_Scores.append(group)
                    }
                    }
                    }
                    self.tableView.reloadData()
                }}
        }}
    }

}


