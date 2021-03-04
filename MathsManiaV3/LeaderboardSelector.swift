//
//  LeaderboardSelector.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class LeaderboardSelector: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LeaderboardBackground copy")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
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
        if segue.identifier == "addition"{
            let destination = segue.destination as! LeaderboardDifficulty
            destination.GameMode = "Plus"
        }
        if segue.identifier == "subtraction"{
            let destination = segue.destination as! LeaderboardDifficulty
            destination.GameMode = "Minus"
        }
        if segue.identifier == "division"{
            let destination = segue.destination as! LeaderboardDifficulty
            destination.GameMode = "Divide"
        }
        if segue.identifier == "multiplication"{
            let destination = segue.destination as! LeaderboardDifficulty
            destination.GameMode = "Multiply"
        }
        if segue.identifier == "all"{
            let destination = segue.destination as! LeaderboardDifficulty
            destination.GameMode = "All"
        }
    }

}
