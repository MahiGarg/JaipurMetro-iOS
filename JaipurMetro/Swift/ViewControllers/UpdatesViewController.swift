//
//  UpdatesViewController.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import UIKit
import CoreLocation

class UpdatesViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var sourceStation : String?
    var destinationStation : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsBtn.layer.cornerRadius = 5
        settingsBtn.clipsToBounds = true
        
        //init location manager
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false;
        self.title = "Updates"
        
        requestPermissionStackView.isHidden = false
        nearestStationsStackView.isHidden = true
    
        manager.startUpdatingLocation()
        
        initClickEvents()
        showRecentSearchResult()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        let comparision = NearestStationComparision()
        
        let result = comparision.getNearestStations(userLat: locations[0].coordinate.latitude, userLong: locations[0].coordinate.longitude)
        
        firstNearestMetroStation.text = result[0].stationName
        secondNearestMetroStation.text = result[1].stationName
        
        requestPermissionStackView.isHidden = true
        nearestStationsStackView.isHidden = false
    }
    
    fileprivate func  showRecentSearchResult(){
        sourceStation = UserDefaults.standard.string(forKey: Utils.Key_LastSearched_SourceStation)
        destinationStation = UserDefaults.standard.string(forKey: Utils.Key_LastSearched_DestinationStation)
        
        if sourceStation == nil || destinationStation == nil || (sourceStation!.isEmpty) || (destinationStation!.isEmpty) {
            recentSearchResultsStackView.isHidden = true
            
            recentSearchStationLabel.text = "You have not searched for\n" +
                                            "any station yet"
            
            recentSearchStationLabel.textColor = UIColor(displayP3Red: 0.447, green: 0.447, blue: 0.447, alpha: 1.0)
            return
        }
        
        recentSearchResultsStackView.isHidden = false
        recentSearchStationLabel.text = "You recently searched for\n" +
            sourceStation! + " to " + destinationStation!
        
        recentSearchStationLabel.textColor = UIColor(displayP3Red: 0.129, green: 0.129, blue: 0.129, alpha: 1.0)
        
        let fareDetailsRepo = FareDetailsRepository()
        let stationFareDetailsObj = fareDetailsRepo.getFareDetailsBetweenStations(sourceStation: sourceStation!,
                                                                                  destinationStation: destinationStation!)
        
        setTextToLabels(fareModelObj: stationFareDetailsObj)
    }
    
    func setTextToLabels(fareModelObj: StationFareModel) {
        distanceLabel.text = fareModelObj.distance
        timeLabel.text = fareModelObj.timeToTravel
        
        setTrainTimings(fareModelObj: fareModelObj)
    }
    
    fileprivate func setTrainTimings(fareModelObj: StationFareModel) {
        
        let trainTimingsRepo = TrainTimingRepository()
        let nextTrainTimings =
            trainTimingsRepo.getNextMetroTimings(sourceStation: sourceStation!, destinationStation: destinationStation!)
        
        nextFirstTrainRemainingTimeLabel.text = nextTrainTimings.trainTimings[0].nextTrainTimeDifference
        nextFirstTrainTimeLabel.text = nextTrainTimings.trainTimings[0].nextTrainTiming
        
        nextSecondTrainRemainingTimeLabel.text = nextTrainTimings.trainTimings[1].nextTrainTimeDifference
        nextSecondTrainTimeLabel.text = nextTrainTimings.trainTimings[1].nextTrainTiming
        
        let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let mins = calendar.component(.minute, from: date)
        
        let lastMetroTime = nextTrainTimings.trainTimings[2]
        
        if hours < 17
            || (hours >= trainTimingsRepo.getHoursFromTime(time: lastMetroTime.nextTrainTiming!)
                && mins >= trainTimingsRepo.getMinsFromTime(time: lastMetroTime.nextTrainTiming!)) {

            fareLabel.text = fareModelObj.standardOffPeakFare!.replacingOccurrences(of: "Rs", with: "₹")
        } else {
            fareLabel.text = fareModelObj.standardPeakFare!.replacingOccurrences(of: "Rs", with: "₹")
        }
    }
    
    fileprivate func initClickEvents(){
        let firstNearestStationGR = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        firstNearestStationGR.name = FIRST_NEAREST_STATION
        firstNearestStationView.addGestureRecognizer(firstNearestStationGR)
        
        let secondNearestStationGR = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        secondNearestStationGR.name = SECOND_NEAREST_STATION
        secondNearestStationView.addGestureRecognizer(secondNearestStationGR)
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        switch sender.name {
        case FIRST_NEAREST_STATION:
            openStationDetails(stationName: firstNearestMetroStation.text!)
            break
            
        case SECOND_NEAREST_STATION:
            openStationDetails(stationName: secondNearestMetroStation.text!)
            break
            
        default:
            break
        }
    }
    
    fileprivate func openStationDetails(stationName: String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let stationDetainsVC = storyBoard.instantiateViewController(withIdentifier: "StationDetailsViewController")
            as! StationDetailsViewController
        
        stationDetainsVC.stationName = stationName
        
        self.navigationController?.pushViewController(stationDetainsVC, animated: true)
        self.title = nil
        
        self.tabBarController?.tabBar.isHidden = true;
    }
    
    @IBAction func OnSettingsButtonClick(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    
    let FIRST_NEAREST_STATION = "first_nearest_station"
    let SECOND_NEAREST_STATION = "second_nearest_station"
    
    @IBOutlet weak var nearestStationsStackView: UIStackView!
    @IBOutlet weak var requestPermissionStackView: UIStackView!
    @IBOutlet weak var settingsBtn: UIButton!
    
    @IBOutlet weak var firstNearestMetroStation: UILabel!
    @IBOutlet weak var secondNearestMetroStation: UILabel!
    
    @IBOutlet weak var firstNearestStationView: UIView!
    @IBOutlet weak var secondNearestStationView: UIView!
    
    @IBOutlet weak var recentSearchResultsStackView: UIStackView!
    
    @IBOutlet weak var recentSearchStationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var fareLabel: UILabel!
    
    @IBOutlet weak var nextFirstTrainRemainingTimeLabel: UILabel!
    @IBOutlet weak var nextFirstTrainTimeLabel: UILabel!
    
    @IBOutlet weak var nextSecondTrainRemainingTimeLabel: UILabel!
    @IBOutlet weak var nextSecondTrainTimeLabel: UILabel!
}
