//
//  StationsAdapter.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation
import UIKit

class StationsAdapter : NSObject, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var stationsArray : [String]
    
    init(stationsArray : [String]) {
        self.stationsArray = stationsArray
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stationsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stationsArray.count
    }
    
}
