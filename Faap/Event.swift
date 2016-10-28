//
//  Event.swift
//  Faap
//
//  Created by Tomer Ciucran on 10/27/16.
//  Copyright © 2016 KPT. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    
    var name: String!
//    var eventDescription: String!
//    var lat: Double!
//    var lng: Double!
    var timeDate: Date!
//    var guests: [String]!
//    var ingredients: [String]!
//    var pictureUrl: String?
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
