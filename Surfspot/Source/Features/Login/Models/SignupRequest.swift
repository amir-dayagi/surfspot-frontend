//
//  SignupRequest.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/17/24.
//

import Foundation

struct SignupRequest: Encodable {
    var first_name: String
    var last_name: String?
    var email: String
    var password: String
}
