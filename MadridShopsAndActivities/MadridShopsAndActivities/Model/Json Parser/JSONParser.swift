//
//  JSONParser.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

func parseShops (data: Data) -> Shops {
    
    let shops = Shops()
    
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String,Any>]
        
        for shopJson in result {
            let shop = Shop(name: shopJson["name"]! as! String)
            shop.description_en = shopJson["description_en"]! as! String
            shop.description_es = shopJson["description_es"]! as! String
            shop.imageUrl = shopJson["img"] as! String
            shop.logoImgUrl = shopJson["logo_img"] as! String
            shop.address = shopJson["address"] as! String
            shops.add(shop: shop)
        }
    } catch {
        print("Error parsing JSON")
    }
    
    return shops
}

func parseActivities (data: Data) -> Activities {

    let activities = Activities()
    
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String,Any>]
        
        for activityJson in result {
            let activity = Activity(name: activityJson["name"]! as! String)
            activity.description_en = activityJson["description_en"]! as! String
            activity.description_es = activityJson["description_es"]! as! String
            activity.imageUrl = activityJson["img"] as! String
            activity.logoImgUrl = activityJson["logo_img"] as! String
            activity.address = activityJson["address"] as! String
            activities.add(activity: activity)
        }
    } catch {
        print("Error parsing JSON")
    }
    
    return activities
}
