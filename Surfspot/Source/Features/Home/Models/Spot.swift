//
//  Spot.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/26/24.
//

import Foundation

struct Spot: Decodable, Identifiable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var radius: Double
}
