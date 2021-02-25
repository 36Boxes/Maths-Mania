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
    var Group_Loc_Scores = [["score" : String(), "location" : String(),"player_name" : String(), "player_ID" : String()]]
    
    let counties : [String] = ["Bath and North East Somerset", "Bedfordshire", "Berkshire", "Bristol", "Buckinghamshire", "Cambridgeshire", "Cheshire","Cornwall", "County Durham", "Cumbria","Derbyshire", "Devon", "Dorset","East Riding of Yorkshire", "East Sussex", "Essex","Gloucestershire", "Greater London", "Greater Manchester","Hampshire", "Herefordshire", "Hertfordshire","Isle of Wight", "Isles of Scilly", "Kent","Lancashire", "Leicestershire", "Lincolnshire","Merseyside", "Norfolk", "North Somerset","North Yorkshire", "Northamptonshire", "Northumberland","Nottinghamshire", "Oxfordshire", "Rutland","Shropshire", "Somerset", "South Gloucestershire","South Yorkshire", "Staffordshire", "Suffolk","Surrey", "Tyne & Wear", "Warwickshire","West Midlands" ,"West Sussex", "West Yorkshire","Wiltshire", "Worcestershire"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Group_Loc_Scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as!
            TableViewCell
        let group_scores = Group_Loc_Scores[indexPath.row]
        let scor = group_scores["score"]!
        let locatio = group_scores["location"]!
        let player_nam = group_scores["player_name"]!
        
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
        
        
        cell.PlayerName.text = player_name
        cell.PlayerArea.text = text_to_show
        cell.PlayerScore.text = score
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        if let locatID = group_scores["location"] as? String{
//            let pop = Int(locatID)
//            if let scored = group_scores["score"]!{
//                let score = String(scored)
//                cell.label1.text = score
//                cell.label2.text = counties[pop]
//                cell.Label3.text = group_scores["player_name"] as? String
//            }else{
//                cell.label2.text = counties[pop]
//                cell.Label3.text = group_scores["player_name"] as? String
//            }
//        } else{
//            let locatID = group_scores["location"] as! String
//            let pop = Int(locatID)
//            cell.label2.text = counties[pop ?? 0]
//            cell.Label3.text = group_scores["player_name"] as? String
//        }
//
//
//
        return cell
    }
    

    
    
    var highScore:Int = 0
        
    @IBOutlet weak var tableView: UITableView!
    @IBAction func showlead(_ sender: Any) {
        showLeader()
    }
    @IBAction func GoBackHome(_ sender: Any) {
//        performSegue(withIdentifier: "backfrontleaderboard", sender: nil)
        print("reloading")
        tableView.reloadData()
        print("done")
        print(Group_Loc_Scores)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        let leaderBoard : GKLeaderboard = GKLeaderboard()
        leaderBoard.timeScope = .allTime
        leaderBoard.identifier = "Locations"
        // load all the leaderboard scores and check to see if the user has set a locationID before the view loads
        leaderBoard.loadScores { scores, error in
            guard let scores = scores else {
                return }
            guard let popsicle = leaderBoard.localPlayerScore?.value
            else{return}
            print(popsicle)
            if leaderBoard.localPlayerScore?.value != nil{
                print("location already logged")
            }else{
                let Locationpopup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "locationpopup") as! LocationPopupViewController

                self.addChild(Locationpopup)
                // ensuring the popup frame is the same as the main view frame
                Locationpopup.view.frame = self.view.frame
                //adding the popup to the view
                self.view.addSubview(Locationpopup.view)
                Locationpopup.didMove(toParent: self)}
        }
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "4157744")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        authPlayer()
        load_leaders()


    }
    
    func load_leaders(){
        let Locations : GKLeaderboard = GKLeaderboard()
        Locations.timeScope = .allTime
        Locations.identifier = "Locations"
        let Scores : GKLeaderboard = GKLeaderboard()
        Scores.timeScope = .allTime
        Scores.identifier = "Scores"
        Scores.loadScores { scores, error in
            guard let scores = scores else {return}
        // load all the leaderboard scores and check to see if the user has set a locationID before the view loads
        Locations.loadScores { locats, error in
            var Group_toAddto_Loc_Scores = [["score" : String(Scores.localPlayerScore!.value), "location" : String(Locations.localPlayerScore!.value),"player_name" : String((Scores.localPlayerScore?.player.alias)!), "player_ID" : String((Scores.localPlayerScore?.player.playerID)!)]]
            self.Group_Loc_Scores.append(contentsOf: Group_toAddto_Loc_Scores)
            guard let locats = locats else {return}
            for score in scores{
                for location in locats{
                    if location.player.playerID == score.player.playerID{
                        print("FOUND A MATCH")
                        let group = ["score" : String(score.value), "location" : String(location.value),"player_name" : String(score.player.alias), "player_ID" : String(score.player.playerID)]
                        print(group)
                        self.Group_Loc_Scores.append(group)
                        
                    }
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

}
