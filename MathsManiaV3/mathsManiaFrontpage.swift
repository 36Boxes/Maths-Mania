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
import GoogleMobileAds



class mathsManiaFrontpage: UIViewController, GKGameCenterControllerDelegate, GADFullScreenContentDelegate{

    private var interstitial: GADInterstitialAd?

    
    // We set this as true as the default and then if they reject the game center login we can set it to false
    
    var GameCenterPlayer = true
    
    
    // GameKit local player variable
    
    let localPlayer = GKLocalPlayer.local
    
    
    // Function to dismiss the gamecenter view controller
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Credits(_ sender: Any) {
        performSegue(withIdentifier: "showcredits", sender: nil)
    }
    // Function for proceeding to the solo mode

    @IBAction func SoloMode(_ sender: Any) {
        performSegue(withIdentifier: "solomode", sender: nil)
    }
    
    // Function for proceeding to the leaderboards
    
    @IBAction func Leaderboards(_ sender: Any) {
        performSegue(withIdentifier: "gototleaderboardselector", sender: nil)
    }
    
    @IBAction func QuickFireMode(_ sender: Any) {
        performSegue(withIdentifier: "operatorselect", sender: nil)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding the background to the application
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "FrontPage")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-6767422419955516/3438680776",
                                    request: request,
                          completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            interstitial = ad
                            interstitial?.fullScreenContentDelegate = self
                          }
        )

        
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


