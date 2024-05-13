//
//  SessionRequest.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/23/24.
//

import Foundation

struct SessionRequest: Encodable {
    var name: String
    var start_datetime: Date
    var spot_id: Int
}
