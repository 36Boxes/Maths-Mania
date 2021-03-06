//
//  LocationPopupViewController.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 17/02/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit
import GameKit
import CoreLocation

class LocationPopupViewController: UIViewController, GKGameCenterControllerDelegate, CLLocationManagerDelegate {
    
    var manager: CLLocationManager = CLLocationManager()
    
    var location_calculated = false
    
    var startTimer: Timer!
    
    let location_string = "Calculating Location....."
    
    let location_string2 = "Calculating Location...."
    
    var flipper = false
    
    let counties : [String] = ["Bath and North East Somerset", "Bedfordshire", "Berkshire", "Bristol", "Buckinghamshire", "Cambridgeshire", "Cheshire","Cornwall", "County Durham", "Cumbria","Derbyshire", "Devon", "Dorset","East Riding of Yorkshire", "East Sussex", "Essex","Gloucestershire", "Greater London", "Greater Manchester","Hampshire", "Herefordshire", "Hertfordshire","Isle of Wight", "Isles of Scilly", "Kent","Lancashire", "Leicestershire", "Lincolnshire","Merseyside", "Norfolk", "North Somerset","North Yorkshire", "Northamptonshire", "Northumberland","Nottinghamshire", "Oxfordshire", "Rutland","Shropshire", "Somerset", "South Gloucestershire","South Yorkshire", "Staffordshire", "Suffolk","Surrey", "Tyne & Wear", "Warwickshire","West Midlands" ,"West Sussex", "West Yorkshire","Wiltshire", "Worcestershire", "ROTW"]
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    @IBAction func skip(_ sender: Any) {
    }
    
    @IBOutlet weak var popupbutton: UIButton!
    @IBOutlet weak var CalculationLabel: UILabel!
    
    @IBOutlet weak var PopupTitle: UILabel!
    @IBOutlet weak var CalculateButton: UIButton!
    @IBAction func getLocation(_ sender: Any) {
        if popupbutton.currentTitle == "Continue"{
            performSegue(withIdentifier: "removepopup", sender: nil)
            location_calculated = true
        }else{
        getUserCounty()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    func getUserCounty(){
        startTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(Updatelocations), userInfo: nil, repeats: true)
        popupbutton.isEnabled = false
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    
    
    @objc func Updatelocations(){
        if flipper != false{
        CalculationLabel.text = location_string
            flipper = false
        }else{
            CalculationLabel.text = location_string2
            flipper = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let place: Void = CLGeocoder().reverseGeocodeLocation(location){ [self](placemark, error) in
                if error != nil{
                print("error")
                }else{
                    if let place = placemark?[0]{
                        let userCounty = place.subAdministrativeArea
                        for (index, county) in self.counties.enumerated(){
                            
                            // If the index reaches 51 we know the user is not within england
                            
                            if index == 51{
                                let locationID = index
                                UserDefaults.standard.set(locationID, forKey: "LocationID")
                                self.saveHigh(number: locationID)
                                startTimer.invalidate()
                                CalculationLabel.text = "Location Calculated!"
                                popupbutton.isEnabled = true
                                popupbutton.setTitle("Continue", for: UIControl.State.normal)
                                CalculateButton.setTitle("Continue", for: UIControl.State.normal)
                                break
                            }else{
                                
                            // Else we want to compare the user county to the counties within our list to decide where the user is
                                
                            if county == userCounty{
                                // The index number will be our locationID
                                let locationID = index
                                UserDefaults.standard.set(locationID, forKey: "LocationID")
                                self.saveHigh(number: locationID)
                                startTimer.invalidate()
                                CalculationLabel.text = "Location Calculated!"
                                popupbutton.isEnabled = true
                                popupbutton.setTitle("Continue", for: UIControl.State.normal)
                                CalculateButton.setTitle("Continue", for: UIControl.State.normal)
                                break
                            }
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
        CalculationLabel.text = "Location Calculated!"
    }
    
    // Function to save the locationID to the leaderboard
    
    func saveHigh(number : Int){
        if GKLocalPlayer.local.isAuthenticated{
            let scoreReporter = GKScore(leaderboardIdentifier: "Locations")
            scoreReporter.value = Int64(number)
            let ScoreArray : [GKScore] = [scoreReporter]
            GKScore.report(ScoreArray, withCompletionHandler: nil)

        }}
    
    // Function thats called when the CLlocation manager fails to find location
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find the location")
    }
}
