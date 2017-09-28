//
//  ActivitiesViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/26/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var timer = Timer()
    
    var shops = Shops()
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Activities"
        
        listCollectionView.register(UINib(nibName:"ActivityCell", bundle: nil), forCellWithReuseIdentifier: ActivityCollectionViewCell.identifier)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
                
        //Check if the data is already downloaded
        if !CheckExecutedOnceInteractorImpl().check(key: kActivitiesSaved) {
            
            //If not, Check every 10 seconds if there is connection until the user connects and then download the data
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.checkConnection), userInfo: nil, repeats: true)
            timer.fire()
        } else {
            //If there data is already downlaoded, no need to check for internet and just use the date from the database
        }
    }
    
    @objc func checkConnection() {
        //If there is no connection show alert, that connection is needed
        if Reachability.isConnectedToNetwork(){
            //Stop timer because a connection was found
            timer.invalidate()
            downloadDataFromInternet()
            print("Internet Connection Available!")
        }else{
            showNoInternetAlert()
            print("Internet Connection not Available!")
        }
    }
    
    func downloadDataFromInternet() {
        //If there is connection, download data, save it in CoreData and set in userdefaults that is already saved
        
        let downloadAllActivitiesInteractor = DownloadAllActivitiesInteractorImpl()
        
        downloadAllActivitiesInteractor.execute { (activities:Activities) in
            
            print("Activity: \(activities.get(index: 0).name)")
            
            let cacheInteractor = SaveAllActivitiesInteractorImplementation()
            cacheInteractor.execute(activities: activities, context: self.context, onSuccess: { (activities) in
                //Once the objects are successfully saved, set in userdefaults so we dont load the data again
                SetExecutedOnceInteractorImpl().set(key: kActivitiesSaved)

                self._fetchedResultsController = nil
                self.listCollectionView.delegate = self
                self.listCollectionView.dataSource = self
                self.listCollectionView.reloadData()
            })
        }
    }
    
    func showNoInternetAlert() {
        
        HelperClass.showOneOptionAlert(title: "No Internet!", message: "There is no connection to internet, please connect so we can get the info for you", okButtonTitle: "OK", presenter: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activity:ActivityCD = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: "ShowDetailSegue", sender: activity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetailSegue" {
            let nextViewController = segue.destination as! DetailViewController
            let activityCD: ActivityCD = sender as! ActivityCD
            //nextViewController.shop = mapShopCDToShop(shopCD: shopCD)
        }
    }
    
    // MARK: - Fetched results controller
    
    var _fetchedResultsController: NSFetchedResultsController<ActivityCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ActivityCD> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: "ActivitiesCacheFile")
        _fetchedResultsController!.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
}


