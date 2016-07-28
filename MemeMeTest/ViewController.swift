//
//  ViewController.swift
//  MemeMeTest
//
//  Created by Caroline Davis on 22/07/2016.
//  Copyright © 2016 Caroline Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraPicker: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UINavigationBar!
    @IBOutlet weak var saveMe: UIBarButtonItem!
    
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    //Creating the meme
    @IBAction func save() {
        
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage:
            imagePickerView.image!, memedImage: generateMemedImage())
        let share = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        self.presentViewController(share, animated: true, completion: nil)
        
      //  UIActivityViewControllerCompletionWithItemsHandler()
    }
    
    
    
    func generateMemedImage() -> UIImage {
        print("I want to kill")
        
        // TODO: Hide toolbar and navbar
        bottomToolBar.hidden = true
        topToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                    afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
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
        
        topText.text = "TOP"
        topText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = .Center
        topText.delegate = self
        
        bottomText.text = "BOTTOM"
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.textAlignment = .Center
        bottomText.delegate = self
        
        saveMe.enabled = false
    }
    
    // Text deletes when user starts typing
    @IBAction func textFieldDidBeginEditing(topText: UITextField, bottomText: UITextField) {
        topText.text = ""
        bottomText.text = ""
    }
    
    // when enter is pressed keyboard is dismissed
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
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // When the keyboardWillShow notification is received, shift the view's frame up      
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    func subscribeToKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
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

    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(pickerController: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            saveMe.enabled = true
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(pickerController: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

