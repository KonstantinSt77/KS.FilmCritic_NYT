//
//  FCFeedTVCell.swift
//  Film Critic
//
//  Created by Kostya on 04.01.2018.
//  Copyright © 2018 SKS. All rights reserved.
//

import UIKit

class FCFeedTVCell: UITableViewCell
{
    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var reviewDescription: UILabel!
    @IBOutlet weak var reviewAuthor: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var avatarStatus: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
