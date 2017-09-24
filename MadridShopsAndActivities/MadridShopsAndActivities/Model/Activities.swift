//
//  Activities.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

public protocol ActivitiesProtocol {
    
    func count() -> Int
    func add(activity: Activity)
    func get(index: Int) -> Activity
}

public class Activities: ActivitiesProtocol {
    
    private var activitiesList: [Activity]?
    
    public init() {
        activitiesList = []
    }
    
    public func count() -> Int {
        return (activitiesList?.count)!
    }
    
    public func add(activity: Activity) {
        activitiesList?.append(activity)
    }
    
    public func get(index: Int) -> Activity {
        return activitiesList![index]
    }
}
