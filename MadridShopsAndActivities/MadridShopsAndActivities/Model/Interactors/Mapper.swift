//
//  ShopsMapping.swift
//  MadridShops
//
//  Created by Tomás Ignacio Moyano on 9/18/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation
import CoreData

func mapShopToShopCD(shop:Shop, context:NSManagedObjectContext) -> ShopCD {
    
    let shopCD = ShopCD(context: context)

    shopCD.name = shop.name
    shopCD.address = shop.address
    shopCD.imageUrl = shop.imageUrl
    shopCD.logoUrl = shop.logoImgUrl
    
    shopCD.latitude = shop.latitude
    shopCD.longitude = shop.longitude
    shopCD.description_es = shop.description_es
    shopCD.openingHours = shop.openingHours
    
    return shopCD
}

func mapShopCDToShop(shopCD:ShopCD) -> Shop {
    
    let shop = Shop(name: shopCD.name!)
    shop.description_es = shopCD.description_es!
    shop.address = shopCD.address!
    shop.imageUrl = shopCD.imageUrl!
    shop.logoImgUrl = shopCD.logoUrl!
    
    shop.latitude = shopCD.latitude
    shop.longitude = shopCD.longitude
    shop.openingHours = shopCD.openingHours!
    
    return shop
}


func mapActivityToActivityCD(activity:Activity, context:NSManagedObjectContext) -> ActivityCD {
    
    let activityCD = ActivityCD(context: context)
    
    activityCD.name = activity.name
    activityCD.address = activity.address
    activityCD.imageUrl = activity.imageUrl
    activityCD.logoUrl = activity.logoImgUrl
    
    activityCD.latitude = activity.latitude
    activityCD.longitude = activity.longitude
    activityCD.description_es = activity.description_es
    activityCD.openingHours = activity.openingHours
    
    return activityCD
}

func mapActivityCDToActivity(activityCD:ActivityCD) -> Activity {
    
    let activity = Activity(name: activityCD.name!)
    activity.description_es = activityCD.description_es!
    activity.address = activityCD.address!
    activity.imageUrl = activityCD.imageUrl!
    activity.logoImgUrl = activityCD.logoUrl!
    
    activity.latitude = activityCD.latitude
    activity.longitude = activityCD.longitude
    activity.openingHours = activityCD.openingHours!
    
    return activity
}
