//
//  PhotoCell.swift
//  Tumblr
//
//  Created by user143116 on 9/10/18.
//  Copyright © 2018 MSU. All rights reserved.
//

import UIKit

class PhotoCell:


UITableViewCell {

    
    @IBOutlet weak var picture: UIImageView!
    
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
