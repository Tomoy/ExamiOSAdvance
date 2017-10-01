//
//  UIViewExtensions.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 10/1/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeCircular() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
}
