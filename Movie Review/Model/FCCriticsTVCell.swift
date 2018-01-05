//
//  FCCriticsTVCell.swift
//  Movie Review
//
//  Created by Kostya on 05.01.2018.
//  Copyright © 2018 SKS. All rights reserved.
//

import UIKit

class FCCriticsTVCell: UITableViewCell
{

    @IBOutlet weak var criticName: UILabel!
    @IBOutlet weak var criticStatus: UILabel!
    @IBOutlet weak var criticSEO: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
