//
//  ChatCell.swift
//  ChatApp
//
//  Created by Isaac Samuel on 10/6/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var labelMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
