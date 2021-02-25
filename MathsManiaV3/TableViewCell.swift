//
//  TableViewCell.swift
//  MathsManiaV3
//
//  Created by Josh Manik on 19/02/2021.
//  Copyright © 2021 Josh Manik. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var PlayerName: UILabel!
    
    @IBOutlet weak var PlayerArea: UILabel!
    
    @IBOutlet weak var PlayerScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
