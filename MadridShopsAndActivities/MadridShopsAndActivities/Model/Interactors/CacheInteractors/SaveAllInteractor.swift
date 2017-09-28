//
//  SaveAllShopsInteractor.swift
//  MadridShops
//
//  Created by Tomás Ignacio Moyano on 9/15/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import CoreData

protocol SaveAllShopsInteractor {
    //Downloads all shops and returns success (Shops) o Error
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void)
}

protocol SaveAllActivitiesInteractor {
    //Downloads all shops and returns success (Shops) o Error
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void, onError: errorClosure)
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void)
}
