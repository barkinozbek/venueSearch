//
//  VenueContainer.swift
//  MyApp
//
//  Created by Barkin Ozbek on 3/19/16.
//

import Foundation
import ObjectMapper

class VenueContainer<Venue :Mappable> : Mappable {
    var venues: [Venue]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        venues <- map["response.venues"]
    }
}