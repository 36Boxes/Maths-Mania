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



class mathsManiaFrontpage: UIViewController, GKGameCenterControllerDelegate {
    
    // We set this as true as the default and then if they reject the game center login we can set it to false
    
    var GameCenterPlayer = true
    
    
    // GameKit local player variable
    
    let localPlayer = GKLocalPlayer.local
    
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding the background to the application
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Backdropexported")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Auth the player here so we can gen leaderboards as we enter leaderboards
        
        authPlayer()
    }
    
    func authPlayer(){
        localPlayer.authenticateHandler = {
            (view, Error) in
            // if they accept show the view
            if view != nil {self.present(view!, animated: true, completion: nil)}
            // if they dont dont show view and log they are not in gamecenter
            else {self.GameCenterPlayer = false}
        }}
    
}


