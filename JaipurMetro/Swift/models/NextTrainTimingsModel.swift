//
//  NextTrainTimingsModel.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

class NextTrainTimingsModel {
 
    var trainTimings = [TrainTiming]()
    
    init() {
    }
    
    internal class TrainTiming {
        var nextTrainTiming : String?
        var nextTrainTimeDifference : String?
        
        init() {
        }
    }
    
}
