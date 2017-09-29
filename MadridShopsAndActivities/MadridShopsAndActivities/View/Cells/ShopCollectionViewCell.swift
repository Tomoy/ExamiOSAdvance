//
//  MadridCollectionViewCell.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {

    static let identifier = "shopCell"
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateInFo(model:ShopCD) {
        nameLabel.text = model.name
    }

}
