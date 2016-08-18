//
//  memeCell.swift
//  MemeMeTest
//
//  Created by Caroline Davis on 18/08/2016.
//  Copyright © 2016 Caroline Davis. All rights reserved.
//

import UIKit

class memeCell: UICollectionViewCell {
    
    var memeImageView: UIImageView!
    
    override init(frame: CGRect) {
        
        memeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        super.init(frame: frame)
        memeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(memeImageView)
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
