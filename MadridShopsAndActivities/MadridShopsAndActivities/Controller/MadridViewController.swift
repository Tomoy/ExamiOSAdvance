//
//  ViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

class MadridViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = parent?.restorationIdentifier
        
        //Check if data is already saved
        
        //If is not saved, check if there is connection to internet
        
        //If there is no connection show alert, that connection is needed
        
        //If there is connection, download data, save it in CoreData and set in userdefaults that is already saved
        
        if parent?.restorationIdentifier == "Shops" {
            
            let downloadAllShopsInteractor = DownloadAllShopsInteractorImpl()
            
            downloadAllShopsInteractor.execute(onSuccess: { (shops:Shops) in
                print("Shop: \(shops.get(index: 0).name)")

            }, onError: { (error:Error) in
                print("Error getting the shops")
            })
            
        } else if parent?.restorationIdentifier == "Activities" {
           
            let downloadAllActivitiesInteractor = DownloadAllActivitiesInteractorImpl()
            
            downloadAllActivitiesInteractor.execute(onSuccess: { (activities:Activities) in
                print("Activity: \(activities.get(index: 0).name)")
                
            }, onError: { (error:Error) in
                print("Error getting the activities")
            })
        }
    }
}

