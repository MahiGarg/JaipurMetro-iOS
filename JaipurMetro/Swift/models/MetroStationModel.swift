//
//  MetroStationModel.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class MetroStationModel : Codable {
    
    var stationName : String?
    var status : String?
    var stationLatitude : String?
    var stationLongitude: String?
    
    var firstMetroTrainTiming : [String]?
    var lastMetroTrainTiming : [String]?
    
    var nearbyHospitalsList : [String]?
    var nearbyCafeAndHotelsList: [String]?
    var nearbyOthersList: [String]?
    var nearbyPoliceStation : String?
    
    var phStationControllerNo : String?
    var phCustomerCareNo: String?
    var phEmergencyBsnlNo: String?
    
    var mailID: String?
    
    init() {
    }
    
    enum CodingKeys: String, CodingKey {
        case stationName = "station_name"
        case status = "status"
        
        case stationLatitude = "station_latitude"
        case stationLongitude = "station_longitude"
        
        case firstMetroTrainTiming = "first_metro_train_timing"
        case lastMetroTrainTiming = "last_metro_train_timing"
        
        case nearbyHospitalsList = "nearby_hospitals_list"
        case nearbyCafeAndHotelsList = "nearby_cafe_and_hotels_list"
        case nearbyOthersList = "nearby_others_list"
        case nearbyPoliceStation = "nearby_police_station"
        
        case phStationControllerNo = "ph_station_controller_no"
        case phCustomerCareNo = "ph_customer_care_no"
        case phEmergencyBsnlNo = "ph_emergency_bsnl_no"
        
        case mailID = "mail_id"
    }
}
