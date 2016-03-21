//
//  Student.swift
//  /Users/barkinozbek/Desktop/Swift/Developer/MyApp
//
//  Created by Barkin Ozbek on 3/14/16.
//
//

import Foundation
import ObjectMapper

class Venue: Mappable {
    var placeName: String?
    var latitude: Double?
    var longitude: Double?
    required init?(_ map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        placeName   <- map["name"]
        latitude    <- map["location.lat"]
        longitude   <- map["location.lng"]
        
    }
    

    init(placeName: String?, latitude: Double?, longitude: Double?){
        self.placeName = placeName
        self.latitude = latitude
        self.longitude = longitude
    }
    func getPlaceName() ->String{
        return self.placeName!
    }
}