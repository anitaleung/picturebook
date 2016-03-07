//
//  ImagePickerViewController.swift
//  picturebook
//
//  Created by Anita on 3/5/16.
//  Copyright © 2016 Anita Leung. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // Do something with the images (based on your use case)
            print("Image picked!")
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }

//    @IBAction func onTakePhoto(sender: AnyObject) {
//        
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        
//        presentViewController(imagePicker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        imagePicker.dismissViewControllerAnimated(true, completion: nil)
//        photoImageView.image = editingInfo![UIImagePickerControllerOriginalImage] as? UIImage
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
