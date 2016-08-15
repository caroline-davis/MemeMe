//
//  SentMemeCollectionViewController.swift
//  MemeMeTest
//
//  Created by Caroline Davis on 10/08/2016.
//  Copyright © 2016 Caroline Davis. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
}