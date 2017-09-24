//
//  Activity.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

public class Activity {
    
    let name:               String
    var description_en:     String = ""
    var description_es:     String = ""
    var latitude:           Float = 0.0
    var longitude:          Float = 0.0
    var imageUrl:           String = ""
    var logoImgUrl:         String = ""
    var openingHours:       String = ""
    var address:            String = ""
    
    public init (name: String) {
        self.name = name
    }
}
