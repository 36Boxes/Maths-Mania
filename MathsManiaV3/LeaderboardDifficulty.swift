//
//  LeaderboardDifficulty.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 04/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class LeaderboardDifficulty: UIViewController {
    
    var GameMode = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Credits")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "hard"{
            if GameMode == "Plus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAdditionHard"
            }
            if GameMode == "Minus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalSubtractionHard"
            }
            if GameMode == "Divide"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalDivisionHard"
            }
            if GameMode == "Multiply"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalMultiplicationHard"
            }
            if GameMode == "All"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAllHard"
            }
        }
        if segue.identifier == "medium"{
            if GameMode == "Plus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAdditionMedium"
            }
            if GameMode == "Minus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalSubtractionMedium"
            }
            if GameMode == "Divide"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalDivisionMedium"
            }
            if GameMode == "Multiply"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalMultiplicationMedium"
            }
            if GameMode == "All"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAllMedium"
            }
        }
        if segue.identifier == "easy"{
            if GameMode == "Plus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAdditionEasy"
            }
            if GameMode == "Minus"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalSubtractionEasy"
            }
            if GameMode == "Divide"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalDivisionEasy"
            }
            if GameMode == "Multiply"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalMultiplicationEasy"
            }
            if GameMode == "All"{
                let destination = segue.destination as! LeaderboardViewController
                destination.LeaderboardIdentifier = "NormalAllEasy"
            }
        }
    }

}
