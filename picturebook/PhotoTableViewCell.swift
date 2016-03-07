//
//  PhotoTableViewCell.swift
//  picturebook
//
//  Created by Anita on 3/5/16.
//  Copyright © 2016 Anita Leung. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoCaptionLabel: UILabel!
    @IBOutlet weak var photoCaptionField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set delegate to textfile
        photoCaptionField.delegate = self
        photoCaptionField.hidden = true
        
        saveButton.hidden = true
        
        // Set field tap
        let tap = UITapGestureRecognizer(target: self, action: "labelTapped")
        tap.numberOfTapsRequired = 1
        photoCaptionLabel.addGestureRecognizer(tap)
    }
    
    @IBAction func onEditButton(sender: AnyObject) {
        photoCaptionField.becomeFirstResponder()
        photoCaptionField.text = ""
        photoCaptionField.hidden = false
        photoCaptionLabel.hidden = true
        editButton.hidden = true
        saveButton.hidden = false
    }
    
    // Delegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("pressed return on row ")
        return true
    }

    // On photo caption label tap
    func labelTapped(gesture: UITapGestureRecognizer) {
        
        // Do whatever you want.
        print("yay it worked")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
