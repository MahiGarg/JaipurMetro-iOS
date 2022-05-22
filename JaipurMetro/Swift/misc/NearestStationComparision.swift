//
//  NearestStationComparision.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class NearestStationComparision {
    
    func getNearestStations(userLat: Double, userLong : Double) -> [StationLatLongModel] {
        
        let metroStations = MetroStations()
        let stationsList = metroStations.getAllWorkingStationsListWithLatLong()
        
        var firstNearestStation : StationLatLongModel?
        var secondNearestStation : StationLatLongModel?
        
        var firstNearestStationDistance : Double = 0
        var secondNearestStationDistance : Double = 0
        
        for station in stationsList {
            
            let distance = getDistance(
                userLat: userLat, userLong: userLong,
                stationLat: station.latitude, stationLong: station.longitude)
            
            if (firstNearestStation == nil) {
                firstNearestStationDistance = distance;
                firstNearestStation = station;
                
            } else if (secondNearestStation == nil) {
                if (distance <= firstNearestStationDistance) {
                    secondNearestStationDistance = firstNearestStationDistance;
                    secondNearestStation = firstNearestStation;
                    
                    firstNearestStationDistance = distance;
                    firstNearestStation = station;
                } else {
                    secondNearestStationDistance = distance;
                    secondNearestStation = station;
                }
            } else if (distance <= firstNearestStationDistance) {
                secondNearestStationDistance = firstNearestStationDistance;
                secondNearestStation = firstNearestStation;
                
                firstNearestStationDistance = distance;
                firstNearestStation = station;
            } else if (distance <= secondNearestStationDistance) {
                secondNearestStationDistance = distance;
                secondNearestStation = station;
            }
        }
        
        var resultantNearestStations = [StationLatLongModel]()
        
        resultantNearestStations.append(firstNearestStation!)
        resultantNearestStations.append(secondNearestStation!)
        
        
        return resultantNearestStations
    }
    
    fileprivate func getDistance(userLat: Double, userLong: Double, stationLat : Double, stationLong: Double) -> Double {
        
        let xCordDist = (userLat) - (stationLat)
        let yCordDist = (userLong) - (stationLong)
        
        let xDistSquare = xCordDist * xCordDist
        let yDistSquare = yCordDist * yCordDist
        
        let distance = (xDistSquare + yDistSquare).squareRoot()
        
        return distance;
    }
    
    
    
}
