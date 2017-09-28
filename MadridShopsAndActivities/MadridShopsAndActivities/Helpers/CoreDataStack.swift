//
//  CoreDataStack.swift
//  CoreDataTest
//
//  Created by Tomás Ignacio Moyano on 9/14/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Core Data stack

public class CoreDataStack {
    
    public func createContainer(dbName:String) -> NSPersistentContainer {

        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("💾 \(storeDescription.description)")
            if let error = error as NSError? {
                fatalError("💩 Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    // MARK: - Core Data Saving support
    
    public func saveContext (context: NSManagedObjectContext) {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                
                let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                let tabBarController = appDelegate.window!.rootViewController as! UITabBarController
                let activeNavController = tabBarController.selectedViewController
                
                if activeNavController != nil {
                    HelperClass.showOneOptionAlert(title: "Error", message: "\(nserror.userInfo)", okButtonTitle: "OK", presenter: activeNavController!)
                }
            }
        }
    }
}
