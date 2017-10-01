//
//  ActivitiesViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/26/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ActivitiesViewController: UIViewController, NSFetchedResultsControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    var timer = Timer()
    var context: NSManagedObjectContext!
    
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 2500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Activities"
        
        //Center Map in Madrid
        let madridLocation = CLLocation(latitude: 40.4268, longitude: -3.7038)
        centerMapOnLocation(madridLocation)
        mapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        listCollectionView.register(UINib(nibName:"ActivityCell", bundle: nil), forCellWithReuseIdentifier: ActivityCollectionViewCell.identifier)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activity:ActivityCD = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowActivityDetailSegue" {
            let detailVC = segue.destination as! ActivityDetailViewController
            let activityCD: ActivityCD = sender as! ActivityCD
            detailVC.activityCD = activityCD
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
    
    // MARK: MapViewDelegate Methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKUserLocation) {
            
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "activityAnnotation")
            annotationView.image = UIImage(named:"activity_pin")
            annotationView.canShowCallout = true
            
            let imageviewFrame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
            let imageView = UIImageView(frame: imageviewFrame)
            imageView.clipsToBounds = true
            let activityAnnotation = annotation as! ActivityAnnotation
            imageView.sd_setImage(with: URL(string: activityAnnotation.logoUrl!))
            annotationView.leftCalloutAccessoryView = imageView
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let activityAnnotation = view.annotation as! ActivityAnnotation
        
        let activityCD = activityAnnotation.activityCD
        performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activityCD)
        
    }
}


