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
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.topLabel.text = self.meme.topText
        self.bottomLabel.text = self.meme.bottomText
        self.imageView.image = self.meme.memedImage
    } 
    
}