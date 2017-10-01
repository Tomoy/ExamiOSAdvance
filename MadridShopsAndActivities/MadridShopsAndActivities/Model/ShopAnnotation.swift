//
//  ShopAnnotation.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 10/1/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation
import MapKit

class ShopAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var logoUrl: String?
    var shopCD: ShopCD?
    
    init(shopCD:ShopCD) {
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(shopCD.latitude)), longitude: CLLocationDegrees(Double(shopCD.longitude)))
        self.coordinate = location
        self.title = shopCD.name
        self.logoUrl = shopCD.logoUrl
        self.shopCD = shopCD
    }
}
