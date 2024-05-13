//
//  Session.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/23/24.
//

import Foundation

struct Session: Decodable, Identifiable, Hashable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    var id: Int
    var create_datetime: Date
    var name: String
    var start_datetime: Date
    var spot: Spot
}

