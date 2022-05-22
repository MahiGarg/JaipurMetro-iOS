//
//  FaresViewController.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import UIKit

class FaresViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var metroStations : MetroStations
    var stationsArray : [String]
    
    var sourceStation : String
    var destinationStation : String
    
    var stationPicker : UIPickerView
    var activeTextField : UITextField!
    
    
    required init?(coder aDecoder: NSCoder) {
        self.metroStations = MetroStations()
        self.stationsArray = self.metroStations.getWorkingStationListToDisplay()
        
        self.stationPicker = UIPickerView()
        self.activeTextField = UITextField()
        
        self.sourceStation = stationsArray[0]
        self.destinationStation = stationsArray[0]
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Fares"
        
        CreateStationPickers()
        
        detailsView.isHidden = true
    }
    
    func CreateStationPickers() {
        sourceStationTextField.delegate = self
        destinationStationTextField.delegate = self
        
        stationPicker.dataSource = self
        stationPicker.delegate = self
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(OnDonePressed))
        toolbar.setItems([done], animated: false)
        
        sourceStationTextField.tintColor = UIColor.clear
        sourceStationTextField.inputAccessoryView = toolbar
        sourceStationTextField.inputView = stationPicker
        
        destinationStationTextField.tintColor = UIColor.clear
        destinationStationTextField.inputAccessoryView = toolbar
        destinationStationTextField.inputView = stationPicker
    }
    
    @objc func OnDonePressed(){
        activeTextField.text = stationsArray[
            stationPicker.selectedRow(inComponent: 0)]
        
        sourceStation = sourceStationTextField.text!
        destinationStation = destinationStationTextField.text!
        
        self.view.endEditing(true)
        
        detailsView.isHidden = true
    }
    
    @IBAction func OnGetFaresButtonClicked(_ sender: Any) {
        detailsView.isHidden = true
        
        if sourceStation.compare(destinationStation) != ComparisonResult.orderedSame {
            UserDefaults.standard.set(sourceStation, forKey: Utils.Key_LastSearched_SourceStation)
            UserDefaults.standard.set(destinationStation, forKey: Utils.Key_LastSearched_DestinationStation)
        }
        
        let fareDetailsRepo = FareDetailsRepository()
        let stationFareDetailsObj = fareDetailsRepo.getFareDetailsBetweenStations(sourceStation: sourceStation, destinationStation: destinationStation)
        
        stationFareDetailsObj.stationsInBetween =
            metroStations.getInbetweenStationsList(
                sourceStationIndex: stationsArray.index(of: sourceStation)!,
                destinationStationIndex: stationsArray.index(of: destinationStation)!)
        
        setTextToLabels(fareModelObj: stationFareDetailsObj)
        detailsView.isHidden = false
    }
    
    func setTextToLabels(fareModelObj: StationFareModel) {
        distanceLabel.text = fareModelObj.distance
        timeLabel.text = fareModelObj.timeToTravel
        
        standardOffpeakFareLabel.text = fareModelObj.standardOffPeakFare!.replacingOccurrences(of: "Rs", with: "₹")
        standardPeakFareLabel.text = fareModelObj.standardPeakFare!.replacingOccurrences(of: "Rs", with: "₹")
        
        if (fareModelObj.stationsInBetween?.count)! < 1 {
            stationsInBetweenLabel.text = "No stations in between"
        } else {
            var textToDisplay = ""
            for (index, station) in (fareModelObj.stationsInBetween?.enumerated())!{
                textToDisplay.append(station)
                if fareModelObj.stationsInBetween!.count > index + 1 {
                    textToDisplay.append("\n")
                }
            }
            
            stationsInBetweenLabel.text = textToDisplay
        }
        
        setTrainTimings()
    }
    
    fileprivate func setTrainTimings() {
        if sourceStation.compare(destinationStation) == ComparisonResult.orderedSame {
            nextTrainStackView.isHidden = true
            return
        }
        
        nextTrainStackView.isHidden = false
        
        let trainTimingsRepo = TrainTimingRepository()
        let nextTrainTimings =
            trainTimingsRepo.getNextMetroTimings(sourceStation: sourceStation, destinationStation: destinationStation)
        
        nextFirstTrainRemainingTimeLabel.text = nextTrainTimings.trainTimings[0].nextTrainTimeDifference
        nextFirstTrainTimeLabel.text = nextTrainTimings.trainTimings[0].nextTrainTiming
        
        nextSecondTrainRemainingTimeLabel.text = nextTrainTimings.trainTimings[1].nextTrainTimeDifference
        nextSecondTrainTimeLabel.text = nextTrainTimings.trainTimings[1].nextTrainTiming
    }
    
    
    // TextField delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    // Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stationsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stationsArray.count
    }
    // Picker view data source end
    
    
    @IBOutlet weak var sourceStationTextField: UITextField!
    @IBOutlet weak var destinationStationTextField: UITextField!
    
    //details sections
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var standardOffpeakFareLabel: UILabel!
    @IBOutlet weak var standardPeakFareLabel: UILabel!
    
    @IBOutlet weak var stationsInBetweenLabel: UILabel!
    
    @IBOutlet weak var nextTrainStackView: UIStackView!
    
    @IBOutlet weak var nextFirstTrainRemainingTimeLabel: UILabel!
    @IBOutlet weak var nextFirstTrainTimeLabel: UILabel!
    
    @IBOutlet weak var nextSecondTrainRemainingTimeLabel: UILabel!
    @IBOutlet weak var nextSecondTrainTimeLabel: UILabel!
}
