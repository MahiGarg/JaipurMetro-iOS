//
//  MetroStations.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class MetroStations {
    
    var workingStationsList : [String]
    var listToDisplay : [String]
    
    init() {
        
        workingStationsList = [String] ()
        workingStationsList.append("Mansarovar")
        workingStationsList.append("New Aatish Market")
        workingStationsList.append("Vivek Vihar")
        workingStationsList.append("Shyam Nagar")
        workingStationsList.append("Ram Nagar")
        workingStationsList.append("Civil Lines")
        workingStationsList.append("Railway Station")
        workingStationsList.append("Sindhi Camp")
        workingStationsList.append("Chandpole")
        
        listToDisplay = [String]()
        listToDisplay.append(NSLocalizedString("mansarovar", comment: "Mansarovar"))
        listToDisplay.append(NSLocalizedString("new_aatish_market", comment: "New Aatish Market"))
        listToDisplay.append(NSLocalizedString("vivek_vihar", comment: "Vivek Vihar"))
        listToDisplay.append(NSLocalizedString("shyam_nagar", comment: "Shyam Nagar"))
        listToDisplay.append(NSLocalizedString("ram_nagar", comment: "Ram Nagar"))
        listToDisplay.append(NSLocalizedString("civil_lines", comment: "Civil Lines"))
        listToDisplay.append(NSLocalizedString("railway_station", comment: "Railway Station"))
        listToDisplay.append(NSLocalizedString("sindhi_camp", comment: "Sindhi Camp"))
        listToDisplay.append(NSLocalizedString("chandpole", comment: "Chandpole"))
    }
    
    func getWorkingStationsList() -> [String] {
        return workingStationsList
    }
    
    func getWorkingStationListToDisplay() -> [String] {
        return workingStationsList
    }
    
    func getInbetweenStationsList(sourceStationIndex: Int, destinationStationIndex: Int) -> [String] {
        var stationList = [String]()
        
        if (destinationStationIndex - sourceStationIndex > 1) {
            for index in (sourceStationIndex + 1...destinationStationIndex - 1) {
                stationList.append(workingStationsList[index])
            }
        } else if (sourceStationIndex - destinationStationIndex > 1) {
            for index in (destinationStationIndex + 1...sourceStationIndex - 1).reversed() {
                stationList.append(workingStationsList[index])
            }
        }
        
        return stationList
    }
    
    func getAllWorkingStationsListWithLatLong() -> [StationLatLongModel] {
        var WorkingStationsList = [StationLatLongModel]()
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Mansarovar", latitude: 26.879512, longitude: 75.749981))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "New Aatish Market", latitude: 26.880317, longitude: 75.764516))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Vivek Vihar", latitude: 26.889102, longitude: 75.768550))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Shyam Nagar", latitude: 26.896423, longitude: 75.770621))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Ram Nagar", latitude: 26.902020, longitude: 75.774745))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Civil Lines", latitude: 26.909600, longitude: 75.781307))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Railway Station", latitude: 26.917918, longitude: 75.790142))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Sindhi Camp", latitude: 26.922580, longitude: 75.799733))
        
        WorkingStationsList.append(StationLatLongModel(stationName: "Chandpole", latitude: 26.926363, longitude: 75.807461))
        
        return WorkingStationsList;
    }
    
    func getDirection(sourceStation : String, destinationStation: String) -> Utils.Directions {
        let sourceStationIndex = workingStationsList.index(of: sourceStation)
        let destinationStationIndex = workingStationsList.index(of: destinationStation)
        
        return sourceStationIndex! - destinationStationIndex! > 0 ?
            Utils.Directions.TOWARDS_MANSAROVAR : Utils.Directions.TOWARDS_CHANDPOLE;
    }
    
}
