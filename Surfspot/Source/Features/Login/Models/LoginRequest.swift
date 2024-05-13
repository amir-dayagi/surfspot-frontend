//
//  LoginRequest.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/17/24.
//

import Foundation

struct LoginRequest: Encodable {
    var email: String
    var password: String
}
