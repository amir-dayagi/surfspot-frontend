//
//  SpotRequest.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/26/24.
//

import Foundation

struct SpotRequest: Encodable {
    var name: String
    var latitude: Double
    var longitude: Double
    var radius: Double
}
