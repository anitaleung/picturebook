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
    var mainImages : [UIImage] = []
    var imagesObjects : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Retrieve data from parse.com
        let query = PFQuery(className:"Images")
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
    
//    func populateImages(object) {
//        let query = PFQuery(className:"Item")
//        query.getObjectInBackgroundWithId(object.objectId!) {
//            (photo: PFObject?, error: NSError?) -> Void in
//            if error == nil && photo != nil {
//                let pfFile = photo!["image"] as! PFFile
//                print("pffile: \(pfFile)")
//                pfFile.getDataInBackgroundWithBlock({ ( imageData: NSData?, error: NSError?) -> Void in
//                    if error == nil{
//                        self.mainImages.append(UIImage(data: imageData!)!)
//                        self.tableView.reloadData()
//                        //cell.imageView!.image = UIImage(data: imageData!)
//                    } else {
//                        print("No image found")
//                    }
//                })
//                
//            } else {
//                print(error)
//            }
//        }
//    }
    
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
    
//    func getImage() {
//        let query = PFQuery(className:"Item")
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [PFObject]?, error: NSError?) -> Void in
//            
//            if error == nil {
//                // The find succeeded.
//                print("Successfully retrieved \(objects!.count) scores.")
//                // Do something with the found objects
//                if let objects = objects {
//                    for object in objects {
//                        //cell.imageView.image = object[]
//                        print(object.objectId)
//                        query.getObjectInBackgroundWithId(object.objectId!) {
//                            (photo: PFObject?, error: NSError?) -> Void in
//                            if error == nil && photo != nil {
//                                let pfFile = photo!["image"] as! PFFile
//                                print(pfFile)
//                                pfFile.getDataInBackgroundWithBlock({ ( imageData: NSData?, error: NSError?) -> Void in
//                                    if error == nil{
//                                        cell.imageView!.image = UIImage(data: imageData!)
//                                    } else {
//                                        print("No image found")
//                                    }
//                                })
//                                
//                            } else {
//                                print(error)
//                            }
//                        }
//                    }
//                }
//            } else {
//                // Log details of the failure
//                print("Error: \(error!) \(error!.userInfo)")
//            }
//        }
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell:PhotoTableViewCell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell", forIndexPath: indexPath) as! PhotoTableViewCell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell", forIndexPath: indexPath) as! PhotoTableViewCell
        
        let query = imagesObjects[indexPath.row]
        
        let pfFile = query["image"] as! PFFile
        
        
        pfFile.getDataInBackgroundWithBlock({ ( imageData: NSData?, error: NSError?) -> Void in
            if error == nil{
                cell.photoImageView.image = UIImage(data: imageData!)
            } else {
                print("No image found")
            }
        })
        
        
        cell.photoCaptionLabel.text = ("Image \(indexPath.row)")
        
        
        //cell.photoCaptionLabel!.text = query.objectForKey("Images") as? String
        
//        return cell
        
        
//
//        if mainImages.count > 0 {
//            print("there are \(mainImages.count) images")
//            print(mainImages)
//            cell.imageView!.image = mainImages[indexPath.row]
//        }
//        

        return cell
        
//        let row = indexPath.row
//        var individualUser = userArray[row] as! PFUser
//        var username = individualUser.username as String
//        
//        var pfimage = individualUser["image"] as! PFFile
//        
//        pfimage.getDataInBackgroundWithBlock({
//            (result, error) in
//            cell.userImage.image = UIImage(data: result)
//        })
//        cell.usernameLabel.text = username
        
        
        
        
//        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell")
//        if cell != nil {
            //cell = Customcells(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
//        }
        
//        let cell = UITableViewCell(style: .Default, reuseIdentifier: "PhotoTableViewCell")
        
        // Extract values from the PFObject to display in the table cell
//        if let nameEnglish = object?["nameEnglish"] as? String {
//            cell.customNameEnglish.text = nameEnglish
//        }
//        if let capital = object?["capital"] as? String {
//            cell.customCapital.text = capital
//        }
        
        // Display flag image
//        let photo = UIImage(named: "Item")
//        cell.imageView!.image = photo
//        if let image = object?["image"] as? PFFile {
//            cell.imageView.image = photo
//            cell.customFlag.loadInBackground()
//        }
        
//        return cell
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
