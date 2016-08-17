//
//  MemeEditorViewController.swift
//  MemeMeTest
//
//  Created by Caroline Davis on 22/07/2016.
//  Copyright © 2016 Caroline Davis. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraPicker: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UINavigationBar!
    @IBOutlet weak var shareMe: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    
    //Creating the meme
    func save() {
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        // Add meme to array of memes on the app delegate file
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func share() {
        let memedImage = self.generateMemedImage()
        let share = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        // If user finishes an action in the activity view controller we call the save method and dismiss view controller
        share.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        self.presentViewController(share, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {

        // Hide toolbar and navbar
        bottomToolBar.hidden = true
        topToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        bottomToolBar.hidden = false
        topToolBar.hidden = false
        
        return memedImage
    }
    
    // Setting the text
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Defining default text field values
        func configureTextFields(textField: UITextField, text: String, tag: Int) {
            textField.text = text
            textField.defaultTextAttributes = memeTextAttributes
            textField.textAlignment = .Center
            textField.tag = tag
            textField.delegate = self
        }
        
        configureTextFields(topText, text: "TOP", tag: 1)
        configureTextFields(bottomText, text: "BOTTOM", tag: 2)
        
        shareMe.enabled = false
        
        // Adds right bar button "Cancel"
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(cancel))
        
    }
    

    // Navigates the cancel button back to the start
    @IBAction func cancelView() {
        self.dismissViewControllerAnimated(true, completion: {})
        //if let navigationController = self.navigationController {
            //navigationController.popToRootViewControllerAnimated(true)
        //}
    }
    
    
    var topTextCounter = 0
    var bottomTextCounter = 0
    
    // Text deletes when User starts typing    
    @IBAction func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 1 {
            if topTextCounter == 0 {
                topText.text = ""
                topTextCounter += 1
            }
        } else if textField.tag == 2 {
            if bottomTextCounter == 0 {
                bottomText.text = ""
                bottomTextCounter += 1
            }
        }
    }
    
    // When enter is pressed keyboard is dismissed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        subscribeToKeyboardHideNotifications()
        let cameraButton = cameraPicker
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardHideNotifications()
    }
    
    // Hides the battery, time etc on the phone/ipad
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // When the keyboardWillShow notification is received, shift the view's frame up
    // - Only set for bottom text to make sure top text is always seen
    func keyboardWillShow(notification: NSNotification) {
        if self.bottomText.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification) - 45
        }
    }
    
    func subscribeToKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // When the keyboardWillHide notification is received, shift the view's frame down
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // Choosing an image based on source type
    func pickImage(sourceType: String) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if(sourceType == "photo") {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if (sourceType == "camera") {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        pickImage("photo")
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        pickImage("camera")
    }
    
    
    func imagePickerController(pickerController: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareMe.enabled = true
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(pickerController: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

