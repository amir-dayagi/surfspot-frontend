//
//  LoginResponse.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/3/24.
//

import Foundation


struct LoginResponse: Decodable {
    var token: String
    var exp: String
}

