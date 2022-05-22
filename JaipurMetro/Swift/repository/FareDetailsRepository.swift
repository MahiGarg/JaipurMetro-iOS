//
//  FareDetailsRepository.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation
import UIKit

class FareDetailsRepository {
    
    func getFareDetailsBetweenStations(sourceStation: String, destinationStation: String) -> StationFareModel {
        let fileName = getSourceFileName(sourceStationName: sourceStation)
        
        let path = Bundle.main.path(forResource: fileName, ofType: ".txt")
        let url = URL(fileURLWithPath: path!)
        
        do{
            let data = try Data(contentsOf: url)
            let stationFareModel = try JSONDecoder().decode([String : [StationFareModel]].self, from: data)

            let stations = stationFareModel["StationFareModel"]
            
            for model in stations! {
                if (model.destinationStationName?.caseInsensitiveCompare(destinationStation) == ComparisonResult.orderedSame) {
                    return model
                }
            }
        }
        catch {}
        
        return StationFareModel()
    }
    
    func getSourceFileName(sourceStationName: String) -> String {
        return "from_" + sourceStationName.lowercased().replacingOccurrences(of: " ", with: "_") + "_to";
    }
    
}
