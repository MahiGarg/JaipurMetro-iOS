//
//  StationDetailsRepository.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class StationDetailsRepository {
    
    func getStationDetailsFromTextFile(stationName: String) -> MetroStationModel {
        let fileName = getSourceFileName()
        
        let path = Bundle.main.path(forResource: fileName, ofType: ".txt")
        let url = URL(fileURLWithPath: path!)
        
        do{
            let data = try Data(contentsOf: url)
            let metroStationModel = try JSONDecoder().decode([String : [MetroStationModel]].self, from: data)
            
            let stations = metroStationModel["metro_stations"]
            
            for model in stations! {
                if (model.stationName?.caseInsensitiveCompare(stationName) == ComparisonResult.orderedSame) {
                    return model
                }
            }
        }
        catch {}
        
        return MetroStationModel()
    }
    
    func getSourceFileName() -> String {
        return "metro_stations";
    }
}
