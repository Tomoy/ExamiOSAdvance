//
//  AppDelegate.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreDataStack = CoreDataStack()
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        context = coreDataStack.createContainer(dbName: "MadridShopsAndActivities").viewContext

        let tabBarController = window!.rootViewController as! MadridTabBarController
        tabBarController.context = context!
        
        if let rootViewController = tabBarController.viewControllers?.first as? ShopsViewController {
            rootViewController.context = context
        }
        

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //Save context before app closes
        guard let context = self.context else { return }
        coreDataStack.saveContext(context: context)
    }

}

