//
//  NoScorePopupViewController.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 28/02/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class NoScorePopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    

}
