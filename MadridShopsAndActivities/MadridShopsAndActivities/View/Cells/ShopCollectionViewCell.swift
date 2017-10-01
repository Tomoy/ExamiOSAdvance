//
//  MadridCollectionViewCell.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import SDWebImage

class ShopCollectionViewCell: UICollectionViewCell {

    static let identifier = "shopCell"
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImgView.makeCircular()
    }
    
    func updateInFo(model:ShopCD) {
        nameLabel.text = model.name
        
        if let logoUrl = model.logoUrl {
            logoImgView.sd_setImage(with: URL(string: logoUrl), placeholderImage: UIImage(named: "default_shop"))
        }
    }

}
