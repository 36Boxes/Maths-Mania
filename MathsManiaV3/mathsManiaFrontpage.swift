//
//  mathsManiaFrontpage.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 31/12/2020.
//  Copyright © 2020 Josh Manik. All rights reserved.
//

import UIKit
import GameKit

import MapKit
import CoreLocation



class mathsManiaFrontpage: UIViewController, GKGameCenterControllerDelegate, CLLocationManagerDelegate {
    
    // This is just a placeholder as the locationID will never be 1000
    
    var locationID : Int64 = 1000
    
    // We set this as true as the default and then if they reject the game center login we can set it to false
    
    var GameCenterPlayer = true
    
    // We set this as true as the default so we then try to get the users locationID and if it returns nil then we know we need to figure it out!
    
    var LocationSet = true
    
    // GameKit local player variable
    
    let localPlayer = GKLocalPlayer.local
    
    // Our ordered list of counties we use to calculate locationIDs
    
    let counties : [String] = ["Bath and North East Somerset", "Bedfordshire", "Berkshire", "Bristol", "Buckinghamshire", "Cambridgeshire", "Cheshire","Cornwall", "County Durham", "Cumbria","Derbyshire", "Devon", "Dorset","East Riding of Yorkshire", "East Sussex", "Essex","Gloucestershire", "Greater London", "Greater Manchester","Hampshire", "Herefordshire", "Hertfordshire","Isle of Wight", "Isles of Scilly", "Kent","Lancashire", "Leicestershire", "Lincolnshire","Merseyside", "Norfolk", "North Somerset","North Yorkshire", "Northamptonshire", "Northumberland","Nottinghamshire", "Oxfordshire", "Rutland","Shropshire", "Somerset", "South Gloucestershire","South Yorkshire", "Staffordshire", "Suffolk","Surrey", "Tyne & Wear", "Warwickshire","West Midlands" ,"West Sussex", "West Yorkshire","Wiltshire", "Worcestershire"]
    
    // Location manager to get users current county
    
    var manager: CLLocationManager = CLLocationManager()
    
    // Function to dismiss the gamecenter view controller
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // Function for proceeding to the solo mode

    @IBAction func SoloMode(_ sender: Any) {
        performSegue(withIdentifier: "solomode", sender: nil)
    }
    
    // Function for proceeding to the leaderboards
    
    @IBAction func Leaderboards(_ sender: Any) {
        performSegue(withIdentifier: "leaderboard", sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // We have to auth the user as the app loads so we can decide wether they are a game center player
        authPlayer()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Adding the background to the application
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Assign the locationID leaderboard to a leaderboard object
        let leaderBoard : GKLeaderboard = GKLeaderboard()
        leaderBoard.timeScope = .allTime
        leaderBoard.identifier = "Locations"
        // load all the leaderboard scores and check to see if the user has set a locationID before the view loads
        leaderBoard.loadScores { scores, error in
            guard let scores = scores else {
                return }
            for score in scores {
                guard let popsicle = leaderBoard.localPlayerScore?.value
                else{
                    print("returning the popsicle")
                    return}
                if popsicle == nil{
                    self.LocationSet = false
                }else{self.LocationSet = true}
                }
        }
        if LocationSet == false{
            let Locationpopup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "locationpopup") as! LocationPopupViewController

            self.addChild(Locationpopup)
            // ensuring the popup frame is the same as the main view frame
            Locationpopup.view.frame = self.view.frame
            //adding the popup to the view
            self.view.addSubview(Locationpopup.view)
            Locationpopup.didMove(toParent: self)
        }
    }
    
    
    
    
    
    
    
    
    
    func authPlayer(){
        localPlayer.authenticateHandler = {
            (view, Error) in
            // if they accept show the view
            if view != nil {self.present(view!, animated: true, completion: nil)}
            // if they dont dont show view and log they are not in gamecenter
            else {self.GameCenterPlayer = false}
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get the first location
        if let location = locations.first {
            // we then need to change the location into a friendly name so we can calc the locationID
            let place: Void = CLGeocoder().reverseGeocodeLocation(location){(placemark, error) in
                // if there is an error in (which has never happened so im unsure wether to put something in here to manually assign location)
                if error != nil{
                print("error")
                }else{
                    // if there was no error we need to calc the locationID
                    if let place = placemark?[0]{
                        // subAdministriveArea gives us the users county
                        let userCounty = place.subAdministrativeArea
                        // iterate through the county list while comparing to users county to find the locationID
                        for (index, county) in self.counties.enumerated(){
                            if county == userCounty{
                                // The index number will be our locationID
                                let locationID = index
                                // set the location in userdefaults
                                UserDefaults.standard.set(locationID, forKey: "LocationID")
                                // save the location
                                self.saveHigh(number: locationID)
                            }}}}}}}
    
    func saveHigh(number : Int){
        // Check if they have been authed
        if GKLocalPlayer.local.isAuthenticated{
            // find the leaderboard we want
            let scoreReporter = GKScore(leaderboardIdentifier: "Locations")
            // assign the value we want to log
            scoreReporter.value = Int64(number)
            // add the values into the leaderboard
            let ScoreArray : [GKScore] = [scoreReporter]
            GKScore.report(ScoreArray, withCompletionHandler: nil)
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location")
    }
}
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let first = locations.first else{
//            return
//        }


