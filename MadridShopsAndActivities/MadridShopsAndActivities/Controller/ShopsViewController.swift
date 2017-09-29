//
//  ViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData

class ShopsViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var timer = Timer()
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shops"
        
        listCollectionView.register(UINib(nibName:"ShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        //Check if the data is already downloaded
        if !CheckExecutedOnceInteractorImpl().check(key: kDataSaved) {
            
            //If not, Check every 10 seconds if there is connection until the user connects and then download the data
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.checkConnection), userInfo: nil, repeats: true)
            timer.fire()
        }
    }
    
    @objc func checkConnection() {
        //If there is no connection show alert, that connection is needed
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            //Stop timer because a connection was found
            timer.invalidate()
            //Download all data and set to downloaded
            //Start loading spinner
            HelperClass.downloadAndStoreLocallyAllData(context: context, callback: { (success:Bool, error:Error?) in
                
                if success {
                    //Stop loading spinner
                    self._fetchedResultsController = nil
                    self.listCollectionView.reloadData()
                } else {
                    HelperClass.showOneOptionAlert(title: "Error!", message: "An error occurred downloading the data: \(error)", okButtonTitle: "OK", presenter: self)
                }
            })
            
        }else{
            showNoInternetAlert()
            //Disable buttons
            print("Internet Connection not Available!")
        }
    }
    
    func showNoInternetAlert() {
        
        HelperClass.showOneOptionAlert(title: "No Internet!", message: "There is no connection to internet, please connect so we can get the info for you", okButtonTitle: "OK", presenter: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let shop:ShopCD = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: "ShowDetailSegue", sender: shop)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetailSegue" {
            let nextViewController = segue.destination as! DetailViewController
            let shopCD: ShopCD = sender as! ShopCD
            //nextViewController.shop = mapShopCDToShop(shopCD: shopCD)
        }
    }
    
    // MARK: - Fetched results controller
    
    var _fetchedResultsController: NSFetchedResultsController<ShopCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ShopCD> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
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

