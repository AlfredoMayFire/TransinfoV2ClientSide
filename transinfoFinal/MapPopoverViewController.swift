//
//  MapPopoverViewController.swift
//  transinfoFinal
//
//  Created by Jessica Cotrina Revilla on 7/31/16.
//  Copyright © 2016 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapPopoverViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeField: UITextField!

    let manager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        //
        self.mapView.showsUserLocation = true

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        if let userLocation = locations.first {
            
        
        self.latitudeField.text = "\(userLocation.coordinate.latitude)"
        self.longitudeField.text = "\(userLocation.coordinate.longitude)"
        
        
        }
        
        let location = locations.first
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated: true)
        self.manager.stopUpdatingLocation()
        
    
    }
    func locationManager(manager: CLLocationManager, didFailWhitError error: NSError) {
    //print("Errors:" + error.localizedDescription)    
    }

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }

}
