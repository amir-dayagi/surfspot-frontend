//
//  User.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/28/24.
//

import Foundation

struct User: Decodable, Identifiable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(email)
    }
    
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
}
