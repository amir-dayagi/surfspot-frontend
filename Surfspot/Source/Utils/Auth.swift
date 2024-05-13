//
//  Auth.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/23/24.
//

import Foundation
import SwiftKeychainWrapper

class Auth: ObservableObject {
    @Published var loggedIn: Bool = false
    
    static let shared = Auth()
    
    public init() {
        loggedIn = hasToken()
    }
    
    
    func setToken(token: String) {
        KeychainWrapper.standard.set(token, forKey: "token")
        
        loggedIn = true
    }
    
    func hasToken() -> Bool {
        return KeychainWrapper.standard.string(forKey: "token") != nil
    }
    
    func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "token")
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: "token")
        
        loggedIn = false
    }
    
}

