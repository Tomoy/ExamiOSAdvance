//
//  ActivitiesCollectionViewCell.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/26/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import SDWebImage

class ActivityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "activityCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImgView.makeCircular()
    }
    
    func updateInFo(model:ActivityCD) {
        nameLabel.text = model.name
        
        if let logoUrl = model.logoUrl {
            logoImgView.sd_setImage(with: URL(string: logoUrl), placeholderImage: UIImage(named: "default_activity"))
        }
    }
}
