//
//  PhotoTableViewCell.swift
//  picturebook
//
//  Created by Anita on 3/5/16.
//  Copyright © 2016 Anita Leung. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoCaptionLabel: UILabel!
    @IBOutlet weak var photoCaptionField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
