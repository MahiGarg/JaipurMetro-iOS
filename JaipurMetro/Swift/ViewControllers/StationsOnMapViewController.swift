//
//  StationsOnMapViewController.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StationsOnMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var stationsList : [StationLatLongModel]?
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init location manager
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let metroStations = MetroStations()
        stationsList = metroStations.getAllWorkingStationsListWithLatLong()
        
        initMarkersAndMap()
    }
    
    fileprivate func initMarkersAndMap() {
        
        self.mapView.showsUserLocation = true
        
        let midStation = stationsList![stationsList!.count / 2]
        let mapCenterLocation = CLLocation(latitude: midStation.latitude, longitude: midStation.longitude)
        
        let regionRadius: CLLocationDistance = 10000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapCenterLocation.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        showMarkersforStations()
    }
    
    fileprivate func showMarkersforStations(){
        
        for station in stationsList! {
            let marker = MKPointAnnotation()
            marker.coordinate = CLLocationCoordinate2DMake(station.latitude, station.longitude)
            marker.title = station.stationName
            marker.subtitle = "Metro Station"
            self.mapView.addAnnotation(marker)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapView.showsUserLocation = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Station On Map"
    }
    
    @IBOutlet weak var mapView: MKMapView!
}
