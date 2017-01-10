//
//  CustomCollectionViewCell.swift
//  Assesment_04
//
//  Created by  shawn on 10/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelForCellText: UILabel!
    
    override func layoutSubviews() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}
