//
//  MadridTabBarController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/28/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData

class MadridTabBarController: UITabBarController, UITabBarControllerDelegate {

    var context:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       
        if let ctx = self.context {
            
            if let activityViewController = viewController as? ActivitiesViewController {
                activityViewController.context = ctx
            } else if let activityViewController = viewController as? ShopsViewController {
                activityViewController.context = ctx
            }
        }
    }
}
