//
//  StationLatLongModel.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class StationLatLongModel {
    var stationName : String
    var latitude : Double
    var longitude : Double
    
    init(stationName: String, latitude: Double, longitude: Double) {
        self.stationName = stationName
        self.latitude = latitude
        self.longitude = longitude
    }
}
