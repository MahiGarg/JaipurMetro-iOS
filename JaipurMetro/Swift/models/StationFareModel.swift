//
//  StationFareModel.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class StationFareModel : Codable {
    
    var destinationStationName: String?
    var distance : String?
    var timeToTravel: String?
    var standardOffPeakFare: String?
    var standardPeakFare: String?
    var stationsInBetween : [String]?
    
    init() {
    }
    
    enum CodingKeys: String, CodingKey {
        case destinationStationName = "DestinationStationName"
        case distance = "Distance"
        
        case timeToTravel = "TimeToTravel"
        case standardOffPeakFare = "StandardOffPeakFare"
        
        case standardPeakFare = "StandardPeakFare"
    }
}
