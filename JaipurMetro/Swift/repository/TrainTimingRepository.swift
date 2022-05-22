//
//  TrainTimingRepository.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation
import UIKit

class TrainTimingRepository {
    
    let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
    }
    
    func getTrainTimings(sourceStation: String) -> MetroTimingsModel {
        let fileName = getSourceFileName(sourceStationName: sourceStation)
        
        let path = Bundle.main.path(forResource: fileName, ofType: ".txt")
        let url = URL(fileURLWithPath: path!)
        
        do{
            let data = try Data(contentsOf: url)
            let metroTimingsJSON = try JSONDecoder().decode([String : [String : [TrainTimeModel]]].self, from: data)
            
            let timings = metroTimingsJSON["train_timing"]
            
            let metroTimings = MetroTimingsModel()
            metroTimings.towardsChandpole = timings![Utils.Directions.TOWARDS_CHANDPOLE.rawValue]
            metroTimings.towardsMansarovar = timings![Utils.Directions.TOWARDS_MANSAROVAR.rawValue]
            
            return metroTimings
        }
        catch {
            print("json error: \(error.localizedDescription)")
        }
        
        return MetroTimingsModel()
    }
    
    
    func getSourceFileName(sourceStationName: String) -> String {
        return "timing_" + sourceStationName.lowercased().replacingOccurrences(of: " ", with: "");
    }
    
    
    func getMetroTimingsInParticularDirection(sourceStation: String, direction: Utils.Directions) -> [TrainTimeModel] {
        let fileName = getSourceFileName(sourceStationName: sourceStation)
        
        let path = Bundle.main.path(forResource: fileName, ofType: ".txt")
        let url = URL(fileURLWithPath: path!)
        
        do{
            let data = try Data(contentsOf: url)
            let metroTimingsJSON = try JSONDecoder().decode([String : [String : [TrainTimeModel]]].self, from: data)
            
            let timings = metroTimingsJSON["train_timing"]
            
            if direction == Utils.Directions.TOWARDS_CHANDPOLE {
                return timings![Utils.Directions.TOWARDS_CHANDPOLE.rawValue]!
            } else {
                return timings![Utils.Directions.TOWARDS_MANSAROVAR.rawValue]!
            }
        }
        catch {
            print("json error: \(error.localizedDescription)")
        }
        
        return [TrainTimeModel]()
    }
    
    func getNextMetroTimings(sourceStation: String, destinationStation: String) -> NextTrainTimingsModel {
        
        let direction = MetroStations().getDirection(sourceStation: sourceStation, destinationStation: destinationStation)
    
        //get all metro timings in particular direction from source station
        let metroTimings = getMetroTimingsInParticularDirection(sourceStation: sourceStation, direction: direction)
        
        //now get current date object
        
        let calender = Calendar.current
        let date = Date()
        let currentTime = Time(calender.component(.hour, from: date), calender.component(.minute, from: date))
        
        
        let lastTrainPos = metroTimings.count - 1
        
        var pos: Int = 0
        
        
        while pos <= lastTrainPos {
            let metroGenericTimings = dateFormatter.date(from: metroTimings[pos].trainTiming!)
            let metroTime = Time(Calendar.current.component(.hour, from: metroGenericTimings!),
                             Calendar.current.component(.minute, from: metroGenericTimings!))
            
            if(metroTime >= currentTime){
                break
            }
            
            pos += 1
        }
        
        let firstTrainTime = NextTrainTimingsModel.TrainTiming()
        let secondTrainTime = NextTrainTimingsModel.TrainTiming()
        
        //No train left for today, show next day trains
        if (pos > lastTrainPos) {
            firstTrainTime.nextTrainTiming = metroTimings[0].trainTiming
            secondTrainTime.nextTrainTiming = metroTimings[1].trainTiming
            
            let firstMetroFormattedTime = dateFormatter.date(from: metroTimings[0].trainTiming!)
            let firstMetroTime = Time(Calendar.current.component(.hour, from: firstMetroFormattedTime!),
                                 Calendar.current.component(.minute, from: firstMetroFormattedTime!))

            firstMetroTime.hour += 24
            
            firstTrainTime.nextTrainTimeDifference = currentTime.findTimeDifference(laterTime: firstMetroTime)
            
            let secondMetroFormattedTime = dateFormatter.date(from: metroTimings[1].trainTiming!)
            let secondMetroTime = Time(Calendar.current.component(.hour, from: secondMetroFormattedTime!),
                                      Calendar.current.component(.minute, from: secondMetroFormattedTime!))
            
            secondMetroTime.hour += 24
            
            secondTrainTime.nextTrainTimeDifference = currentTime.findTimeDifference(laterTime: secondMetroTime)
        }
        
        //Todays last train left
        else if (pos == lastTrainPos) {
            firstTrainTime.nextTrainTiming = metroTimings[lastTrainPos].trainTiming
            secondTrainTime.nextTrainTiming = metroTimings[0].trainTiming
            
            let firstMetroFormattedTime = dateFormatter.date(from: metroTimings[lastTrainPos].trainTiming!)
            let firstMetroTime = Time(Calendar.current.component(.hour, from: firstMetroFormattedTime!),
                                      Calendar.current.component(.minute, from: firstMetroFormattedTime!))
            
            firstTrainTime.nextTrainTimeDifference = currentTime.findTimeDifference(laterTime: firstMetroTime)
            
            let secondMetroFormattedTime = dateFormatter.date(from: metroTimings[0].trainTiming!)
            let secondMetroTime = Time(Calendar.current.component(.hour, from: secondMetroFormattedTime!),
                                       Calendar.current.component(.minute, from: secondMetroFormattedTime!))
            
            secondMetroTime.hour += 24
            
            secondTrainTime.nextTrainTimeDifference = currentTime.findTimeDifference(laterTime: secondMetroTime)
        }
        
        //Todays 2 train left
        else {
            firstTrainTime.nextTrainTiming = metroTimings[pos].trainTiming
            secondTrainTime.nextTrainTiming = metroTimings[pos + 1].trainTiming
            
            let firstMetroFormattedTime = dateFormatter.date(from: metroTimings[pos].trainTiming!)
            let firstMetroTime = Time(Calendar.current.component(.hour, from: firstMetroFormattedTime!),
                                      Calendar.current.component(.minute, from: firstMetroFormattedTime!))
            
            firstTrainTime.nextTrainTimeDifference = currentTime.findTimeDifference(laterTime: firstMetroTime)
            
            let secondMetroFormattedTime = dateFormatter.date(from: metroTimings[pos + 1].trainTiming!)
            let secondMetroTime = Time(Calendar.current.component(.hour, from: secondMetroFormattedTime!),
                                       Calendar.current.component(.minute, from: secondMetroFormattedTime!))
            
            secondTrainTime.nextTrainTimeDifference = currentTime.findTimeDifference(laterTime: secondMetroTime)
        }
        
        let nextTrainTimings = NextTrainTimingsModel()
        nextTrainTimings.trainTimings.append(firstTrainTime)
        nextTrainTimings.trainTimings.append(secondTrainTime)
        
        //include last train time at 3rd position
        let lastMetroTrainTime = NextTrainTimingsModel.TrainTiming()
        lastMetroTrainTime.nextTrainTiming = metroTimings[lastTrainPos].trainTiming
        nextTrainTimings.trainTimings.append(lastMetroTrainTime)
        
        return nextTrainTimings
    }
    
    func getHoursFromTime(time: String) -> Int {
        
        let metroGenericTimings = dateFormatter.date(from: time)
        let metroTime = Time(Calendar.current.component(.hour, from: metroGenericTimings!),
                             Calendar.current.component(.minute, from: metroGenericTimings!))
        
        return metroTime.hour
    }
    
    func getMinsFromTime(time: String) -> Int {
        
        let metroGenericTimings = dateFormatter.date(from: time)
        let metroTime = Time(Calendar.current.component(.hour, from: metroGenericTimings!),
                             Calendar.current.component(.minute, from: metroGenericTimings!))
        
        return metroTime.minute
    }
    
}
