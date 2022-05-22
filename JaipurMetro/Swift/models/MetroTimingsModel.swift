//
//  MetroTimingsModel.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class MetroTimingsModel: Codable {
    
    var towardsChandpole: [TrainTimeModel]?
    var towardsMansarovar : [TrainTimeModel]?
    
    init() {
    }
    
    enum CodingKeys: String, CodingKey {
        case towardsChandpole = "towards_chandpole"
        case towardsMansarovar = "towards_mansarovar"
    }
}
