//
//  MemeDetailViewController.swift
//  MemeMeTest
//
//  Created by Caroline Davis on 16/08/2016.
//  Copyright © 2016 Caroline Davis. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = self.meme.memedImage
        
        // hides tab bar default on bottom
        self.tabBarController?.tabBar.hidden = true
    }
    
    // shows tab bar again when the page is closed
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
}