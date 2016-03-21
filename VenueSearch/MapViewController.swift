//
//  MapViewController.swift
//  MyApp
//
//  Created by Barkin Ozbek on 3/17/16.
//  Copyright © 2016 Barkin Ozbek. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController,MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    var venue: Venue?    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: (venue?.latitude)!,longitude: (venue?.longitude)!)
        centerMapOnLocation(initialLocation)
        let location = CLLocationCoordinate2DMake((venue?.latitude)!, (venue?.longitude)!)
        let annotation = MKPointAnnotation()
        annotation.coordinate.longitude = location.longitude
        annotation.coordinate.latitude = location.latitude
        annotation.title = venue?.placeName
        mapView.addAnnotation(annotation)
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }


}
