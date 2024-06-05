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
    
    
    func setToken(token: String, exp: String) {
        KeychainWrapper.standard.set(token, forKey: "token")
        KeychainWrapper.standard.set(exp, forKey: "exp")
        
        loggedIn = true
    }
    
    func hasToken() -> Bool {
        if KeychainWrapper.standard.string(forKey: "token") == nil ||
            KeychainWrapper.standard.string(forKey: "exp") == nil {
            return false
        }
        let exp_str = KeychainWrapper.standard.string(forKey: "exp")!
        return ISO8601DateFormatter().date(from: exp_str)! < Date.now
    }
    
    func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "token")
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: "token")
        
        loggedIn = false
    }
    
}

