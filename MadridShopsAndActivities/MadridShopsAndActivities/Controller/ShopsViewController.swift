//
//  ViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData
import FillableLoaders
import CoreLocation
import MapKit

class ShopsViewController: UIViewController, NSFetchedResultsControllerDelegate, DataDownloadedDelgate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!

    var timer = Timer()
    var context: NSManagedObjectContext!
    var myLoader: WavesLoader?
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shops"
        
        listCollectionView.register(UINib(nibName:"ShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        //Center Map in Madrid
        let madridLocation = CLLocation(latitude: 40.4168, longitude: -3.7038)
        mapView.setCenter(madridLocation.coordinate, animated: true)
        mapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        //Check if the data is not already downloaded
        if !CheckExecutedOnceInteractorImpl().check(key: kDataSaved) {
            
            //If it is not, then ask the Singleton ConnectionCheckerAndDataDownloader to check connection and download the data if possible
            //Disable TabBar Buttons while checking connection and downloading the data
            enableDisableTabbarButtons(isEnabled: false)
            ConnectionCheckerAndDataDownloader.sharedInstance.check(context: context, caller: self)
            ConnectionCheckerAndDataDownloader.sharedInstance.delegate = self
        }
    }
    
    func enableDisableTabbarButtons(isEnabled:Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tabBarController = appDelegate.window!.rootViewController as! MadridTabBarController
        
        let tabBarItems = tabBarController.tabBar.items!
        for i in 0...tabBarItems.count-1 {
            tabBarItems[i].isEnabled = isEnabled
        }
    }
    
    //DataDownloadedDelegate method, tells when all the data is downloaded
    func dataIsDownloaded() {
        enableDisableTabbarButtons(isEnabled: true)
        self._fetchedResultsController = nil
        self.listCollectionView.reloadData()
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
    
    // MARK: MapViewDelegate Methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKUserLocation) {

            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "shopAnnotation")
            annotationView.image = UIImage(named:"shop_pin")
            return annotationView
        }
 
        return nil
    }
}

