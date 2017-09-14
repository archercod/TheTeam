//
//  TeamListCell.swift
//  TheTeam
//
//  Created by Marcin Pietrzak on 14.09.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

class TeamListCell: UITableViewCell {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
