//
//  ShopDetailViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/26/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import MapKit

class ShopDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var shopCD:ShopCD!
    let regionRadius: CLLocationDistance = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detalle Negocio"
        
        //Center Map in shop location
        let shopLocation = CLLocation(latitude: CLLocationDegrees(Double(shopCD.latitude)), longitude: CLLocationDegrees(Double(shopCD.longitude)))
        centerMapOnLocation(shopLocation)
        mapView.delegate = self
        
        let shopAnnotation = ShopAnnotation(shopCD:shopCD)
        mapView.addAnnotation(shopAnnotation)
        
        nameLabel.text = shopCD.name!
        descriptionTextView.text = shopCD.description_es
        addressLabel.text = shopCD.address
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
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
