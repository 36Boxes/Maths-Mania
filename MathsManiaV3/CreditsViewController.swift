//
//  CreditsViewController.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 02/03/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
  
    @IBAction func gobackhome(_ sender: Any) {
        performSegue(withIdentifier: "exitcredits", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding the background to the application
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Backdropsolomode")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
