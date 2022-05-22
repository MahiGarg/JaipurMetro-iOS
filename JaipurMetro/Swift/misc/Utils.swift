//
//  Utils.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation

class Utils {
    
    static let STATION_MANSAROVAR = "Mansarovar"
    static let STATION_CHANDPOLE = "Chandpole"
    
    static let ENDS_HERE = "Ends\nHere"
    
    static let Key_LastSearched_SourceStation = "lastsearched_sourcestation"
    static let Key_LastSearched_DestinationStation = "lastsearched_destinationstation"
    
    enum Directions : String {
        case TOWARDS_CHANDPOLE = "towards_chandpole"
        case TOWARDS_MANSAROVAR = "towards_mansarovar"
    }
    
    static let OneLink = "http://onelink.to/jaipurmetro"
    
    static let JaipurMetroWebsite = "http://www.jaipurmetrorail.in"    

}
