//
//  VenueContainer.swift
//  MyApp
//
//  Created by Orkun Ozbek on 3/19/16.
//  Copyright © 2016 Barkin Ozbek. All rights reserved.
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