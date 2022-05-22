//
//  TrainTimeModel.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class TrainTimeModel : Codable {
    
    var trainNo: String?
    var trainTiming : String?

    init() {
    }
    
    enum CodingKeys: String, CodingKey {
        case trainNo = "train_no"
        case trainTiming = "train_timing"
    }
}
