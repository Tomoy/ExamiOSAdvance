//
//  HelperClass.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/26/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData

class HelperClass {

    static func showOneOptionAlert(title:String, message:String, okButtonTitle:String, presenter:UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: okButtonTitle, style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        
        alertController.addAction(okAction)
        presenter.present(alertController, animated: true, completion: nil)
    }
    
    static func downloadAndStoreLocallyAllData(context:NSManagedObjectContext ,callback: @escaping (_ success:Bool,_ error:Error?) ->Void) {
        
        let downloadAllShopsInteractor = DownloadAllShopsInteractorImpl()
        
        downloadAllShopsInteractor.execute(onSuccess: { (shops:Shops) in
            print("Shop: \(shops.get(index: 0).name)")
            
            let cacheInteractor = SaveAllShopsInteractorImplementation()
            cacheInteractor.execute(shops: shops, context: context, onSuccess: { (shops) in
                
                //If the shops are successfully downloaded, download the activities
                HelperClass.downloadAndStoreLocallyAllActivities(context: context, callback: { (success:Bool, err:Error?) in
                    
                    //If the activities are properly downloaded, then all data is downloaded, set that data was downloaded and make callback  
                    if success {
                        //Once the objects are successfully saved, set in userdefaults so we dont load the data again
                        SetExecutedOnceInteractorImpl().set(key: kDataSaved)
                        callback(true, nil)
                    } else {
                        callback(false, err)
                    }
                })
            })
        }, onError: { (error:Error) in
            callback(false, error)
        })
    }
    
    static func downloadAndStoreLocallyAllActivities(context:NSManagedObjectContext ,callback: @escaping (_ success:Bool,_ error:Error?) ->Void) {
        
        let downloadAllActivitiesInteractor = DownloadAllActivitiesInteractorImpl()
        
        downloadAllActivitiesInteractor.execute(onSuccess: { (activities:Activities) in
            print("Activity: \(activities.get(index: 0).name)")
            
            let cacheInteractor = SaveAllActivitiesInteractorImplementation()
            cacheInteractor.execute(activities: activities, context: context, onSuccess: { (activities) in
                callback(true, nil)
            })
        }, onError: { (error:Error) in
            callback(false, error)
        })
    }
    
}
