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
        
        collectionView!.registerClass(memeCell.self, forCellWithReuseIdentifier: "Cell")
        
        // The size of the collection view cells
        let space: CGFloat = 3.0
        let width = (self.view.frame.size.width - (2 * space)) / 3.0
        let height = (self.view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(width, height)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView?.reloadData()
    }

    
    // The array of saved meme data coming from AppDelegate
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    // First essential func - number of cells in collectionView
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    // Second essential func - create a cell for each collection view row
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        // reuses a cell or creates a new one
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! memeCell
        let meme = self.memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    // Third essential func - what happens when collectionView cell is tapped
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        detailController.meme = self.memes[indexPath.row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }


    
    
    
}