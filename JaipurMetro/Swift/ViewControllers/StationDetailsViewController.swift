//
//  StationsDetailsViewController.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

class StationDetailsViewController: UIViewController {
    
    var stationName : String?
    var metroStation : MetroStationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAllTrainTimingsBtn.layer.cornerRadius = 5
        showAllTrainTimingsBtn.clipsToBounds = true
        
        let stationRepo = StationDetailsRepository()
        
        metroStation = stationRepo.getStationDetailsFromTextFile(stationName: stationName!)
        
        setTextToLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = stationName!
    }
    
    func setTextToLabels() {
        statusLabel.text = metroStation?.status
        setValuesOfListToLabels(arrayListToDisplay: (metroStation?.firstMetroTrainTiming)!, label: firstMetroTrainTimingLabel)
        setValuesOfListToLabels(arrayListToDisplay: (metroStation?.lastMetroTrainTiming)!, label: lastMetroTrainTimingLabel)
        
        setValuesOfListToLabels(arrayListToDisplay: (metroStation?.nearbyHospitalsList)!, label: nearbyHospitalsLabel)
        setValuesOfListToLabels(arrayListToDisplay: (metroStation?.nearbyCafeAndHotelsList)!, label: nearbyCafesAndHotelsLabel)
        setValuesOfListToLabels(arrayListToDisplay: (metroStation?.nearbyOthersList)!, label: nearbyOthersLabel)
        
        nearbyPoliceStationLabel.text = metroStation?.nearbyPoliceStation
        phControllerNoLabel.text = metroStation?.phStationControllerNo
        phCustomerCareNoLabel.text = metroStation?.phCustomerCareNo
        phEmergencyNoLabel.text = metroStation?.phEmergencyBsnlNo
        
        emailLabel.text = metroStation?.mailID
    }
    
    func setValuesOfListToLabels(arrayListToDisplay: [String], label : UILabel) {
        label.lineBreakMode = NSLineBreakMode.byWordWrapping;
        
        var textToDisplay : String = ""
        for index in 0..<arrayListToDisplay.count{
            textToDisplay.append(arrayListToDisplay[index])
            
            if(arrayListToDisplay.count > (index + 1)){
                textToDisplay.append("\n")
            }
        }
        
        label.text = textToDisplay
        label.sizeToFit()
        label.setNeedsDisplay()
    }
    @IBAction func OnShowAllTrainTimingsClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let metroTimingsVC = storyBoard.instantiateViewController(withIdentifier: "MetroTimingsViewController")
            as! MetroTimingsViewController
        
        metroTimingsVC.stationName = stationName
        
        self.navigationController?.pushViewController(metroTimingsVC, animated: true)
        self.title = nil
    }
    
    @IBAction func OnStationLocationClicked(_ sender: Any) {
        
        guard let latString = metroStation?.stationLatitude! else { return }
        guard let longString = metroStation?.stationLongitude! else { return }
        
        let latitude: CLLocationDegrees = Double(latString)!
        let longitude: CLLocationDegrees = Double(longString)!
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = stationName
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func OnCallControllerClicked(_ sender: Any) {
        performAction(actionUrlString: "tel://" + metroStation!.phStationControllerNo!)
    }
    
    @IBAction func OnCallCustomerCareClicked(_ sender: Any) {
        performAction(actionUrlString: "tel://" + metroStation!.phCustomerCareNo!)
    }
    
    @IBAction func OnCallEmergencyClicked(_ sender: Any) {
        performAction(actionUrlString: "tel://" + metroStation!.phEmergencyBsnlNo!)
    }
    
    @IBAction func OnSendEmailClicked(_ sender: Any) {
        performAction(actionUrlString: "mailto:" + metroStation!.mailID!)
    }
    
    func performAction(actionUrlString:String) {
        let url = URL(string: actionUrlString)
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var firstMetroTrainTimingLabel: UILabel!
    @IBOutlet weak var lastMetroTrainTimingLabel: UILabel!
    
    @IBOutlet weak var showAllTrainTimingsBtn: UIButton!
    
    @IBOutlet weak var nearbyHospitalsLabel: UILabel!
    @IBOutlet weak var nearbyCafesAndHotelsLabel: UILabel!
    @IBOutlet weak var nearbyOthersLabel: UILabel!
    @IBOutlet weak var nearbyPoliceStationLabel: UILabel!
    
    @IBOutlet weak var phControllerNoLabel: UILabel!
    @IBOutlet weak var phCustomerCareNoLabel: UILabel!
    @IBOutlet weak var phEmergencyNoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
}
