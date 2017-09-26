//
//  ViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

class MadridViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var timer = Timer()
    
    var model = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = parent?.restorationIdentifier
        
        listCollectionView.register(UINib(nibName:"MadridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MadridCollectionViewCell.identifier)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        //Check if data is already saved
        
        //If is not saved, check if there is connection to internet
        
        //Check every 10 seconds if there is connection until the user connects
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.checkConnection), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func checkConnection() {
        //If there is no connection show alert, that connection is needed
        if Reachability.isConnectedToNetwork(){
            downloadDataFromInternet()
            timer.invalidate()
            print("Internet Connection Available!")
        }else{
            showNoInternetAlert()
            print("Internet Connection not Available!")
        }
    }
    
    func downloadDataFromInternet() {
        //If there is connection, download data, save it in CoreData and set in userdefaults that is already saved
        
        if parent?.restorationIdentifier == "Shops" {
            
            let downloadAllShopsInteractor = DownloadAllShopsInteractorImpl()
            
            downloadAllShopsInteractor.execute(onSuccess: { (shops:Shops) in
                print("Shop: \(shops.get(index: 0).name)")
                
                for i in 0 ..< shops.count() {
                    let shop = shops.get(index: i)
                    
                    self.model.append(shop)
                }
                
                self.listCollectionView.reloadData()
                
            }, onError: { (error:Error) in
                print("Error getting the shops")
            })
            
        } else if parent?.restorationIdentifier == "Activities" {
            
            let downloadAllActivitiesInteractor = DownloadAllActivitiesInteractorImpl()
            
            downloadAllActivitiesInteractor.execute(onSuccess: { (activities:Activities) in
                print("Activity: \(activities.get(index: 0).name)")
                self.model.append(activities)
                
                self.listCollectionView.reloadData()
                
            }, onError: { (error:Error) in
                print("Error getting the activities")
            })
        }
    }
    
    func showNoInternetAlert() {
        
        let alertController = UIAlertController(title: "No Internet!", message: "There is no connection to internet, please connect so we can get the info for you", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

