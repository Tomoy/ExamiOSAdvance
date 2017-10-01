//
//  ActivityDetailViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 10/1/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import MapKit

class ActivityDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var activityCD:ActivityCD!
    let regionRadius: CLLocationDistance = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detalle Actividad"
        
        //Center Map in ActivityLocation
        let activityLocation = CLLocation(latitude: CLLocationDegrees(Double(activityCD.latitude)), longitude: CLLocationDegrees(Double(activityCD.longitude)))
        centerMapOnLocation(activityLocation)
        mapView.delegate = self
        
        let activityAnnotation = ActivityAnnotation(activityCD: activityCD)
        mapView.addAnnotation(activityAnnotation)
        
        nameLabel.text = activityCD.name!
        descriptionTextView.text = activityCD.description_es
        addressLabel.text = activityCD.address
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: MapViewDelegate Methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKUserLocation) {
            
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "activityAnnotation")
            annotationView.image = UIImage(named:"activity_pin")
            
            return annotationView
        }
        
        return nil
    }
}
