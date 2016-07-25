//
//  ViewController.swift
//  MemeMeTest
//
//  Created by Caroline Davis on 22/07/2016.
//  Copyright © 2016 Caroline Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraPicker: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.text = "TOP"
        topText.textAlignment = .Center
        // topText.delegate = self
        
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = .Center
        // bottomText.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // when enter is pressed keyboard is dismissed
    
    func textFieldDidBeginEditing(topText: UITextField, bottomText: UITextField) {
        topText.text = ""
        bottomText.text = ""
    }
    
    func textFieldShouldReturn(topText: UITextField, bottomText: UITextField) -> Bool {
        topText.resignFirstResponder()
        bottomText.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        let cameraButton = cameraPicker
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
  
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(pickerController: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(pickerController: UIImagePickerController) {
        print("teste")
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}

