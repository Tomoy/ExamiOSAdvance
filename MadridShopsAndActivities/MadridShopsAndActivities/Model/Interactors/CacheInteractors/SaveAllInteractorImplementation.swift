//
//  SaveAllShopsInteractorImplementation.swift
//  MadridShops
//
//  Created by Tomás Ignacio Moyano on 9/15/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import CoreData

class SaveAllShopsInteractorImplementation: SaveAllShopsInteractor {
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        
        for i in 0 ..< shops.count() {
            let shop = shops.get(index: i)
            
            let shopCD = mapShopToShopCD(shop: shop, context: context)
        }
        
        do {
            try context.save()
            onSuccess(shops)
        } catch {
            //onError(nil)
        }
    }
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void) {
        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    }
}

class SaveAllActivitiesInteractorImplementation: SaveAllActivitiesInteractor {
    
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        
        for i in 0 ..< activities.count() {
            let activity = activities.get(index: i)
            
            let activityCD = mapActivityToActivityCD(activity: activity, context: context)
        }
        
        do {
            try context.save()
            onSuccess(activities)
        } catch {
            //onError(nil)
        }
    }
    
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void) {
        execute(activities: activities, context: context, onSuccess: onSuccess, onError: nil)
    }
}
