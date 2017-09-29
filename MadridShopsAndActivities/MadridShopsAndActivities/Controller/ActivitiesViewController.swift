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
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Activities"
        
        listCollectionView.register(UINib(nibName:"ActivityCell", bundle: nil), forCellWithReuseIdentifier: ActivityCollectionViewCell.identifier)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
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


