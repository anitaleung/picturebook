//
//  HomeViewController.swift
//  picturebook
//
//  Created by Anita on 3/5/16.
//  Copyright © 2016 Anita Leung. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var images : [PFObject]?
    var imagesObjects : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Retrieve data from parse.com
        let query = PFQuery(className:"Images")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) objects.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //cell.imageView.image = object[]
                        print("object id: \(object.objectId)")
                        self.imagesObjects.append(object)
                    }
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    
    @IBAction func onPickPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        
        self.presentViewController(imagePicker, animated: true,
            completion: nil)
    }

    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            let newImage = PFFile(data: UIImageJPEGRepresentation(editedImage, 1.0)!)
            
            let photo = PFObject(className: "Images")
            photo["image"] = newImage
            photo.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    print("it's been saved!")
                    self.imagesObjects.insert(photo, atIndex: 0)
                    self.tableView.reloadData()
                } else {
                    // There was a problem, check error.description
                    print(error?.description)
                }
            }
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell", forIndexPath: indexPath) as! PhotoTableViewCell
        
        let query = imagesObjects[indexPath.row]
        let pfFile = query["image"] as! PFFile
        
        // Set image
        pfFile.getDataInBackgroundWithBlock({ ( imageData: NSData?, error: NSError?) -> Void in
            if error == nil{
                cell.photoImageView.image = UIImage(data: imageData!)
            } else {
                print("No image found")
            }
        })
        
        // Set caption
        if let caption = query["caption"] {
            cell.photoCaptionLabel.text = caption as? String
        } else {
            let tempDescription = "Image \(indexPath.row + 1)"
            cell.photoCaptionLabel.text = tempDescription
        }
        
        return cell
    }
    

    
    // On table cell select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as! PhotoTableViewCell
        
        let imageObject = imagesObjects[indexPath!.row]
        let query = PFQuery(className:"Images")
        
        print(currentCell.photoCaptionField.text!)
        
        query.getObjectInBackgroundWithId(imageObject.objectId!) {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let object = object {
                object["caption"] = currentCell.photoCaptionField.text!
                object.saveInBackground()
                currentCell.photoCaptionField.hidden = true
                currentCell.photoCaptionLabel.hidden = false
                currentCell.editButton.hidden = false
                currentCell.saveButton.hidden = true
                self.tableView.reloadData()
            }
        }
        
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
    }
    
    // Detect when save button is pressed
    func buttonClicked(sender:UIButton) {
        let buttonRow = sender.tag
        let imageObject = imagesObjects[buttonRow]
        print(buttonRow)
        print(imageObject.objectId)
        
        let query = PFQuery(className:"Images")
        query.getObjectInBackgroundWithId(imageObject.objectId!) {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let object = object {
                object["caption"] = "testing"
                object.saveInBackground()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesObjects.count
    }

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
