//
//  ActivityAnnotation.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 10/1/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation
import MapKit

class ActivityAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var logoUrl: String?
    var activityCD: ActivityCD?
    
    init(activityCD:ActivityCD) {
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(activityCD.latitude)), longitude: CLLocationDegrees(Double(activityCD.longitude)))
        self.coordinate = location
        self.title = activityCD.name
        self.logoUrl = activityCD.logoUrl
        self.activityCD = activityCD
    }
}
