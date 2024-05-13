//
//  LoginModel.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/24/24.
//

import Foundation


class LoginModel: ObservableObject {
    @Published var path = [Int]()
    @Published var errorMsg = ""
    let authService: AuthService
    
    init(_ authService: AuthService) {
        self.authService = authService
    }
    
    func login(_ email: String, _ password: String) async {
        do {
            errorMsg = ""
            let loginResponse = try await authService.login(LoginRequest(email: email,
                                                                         password: password))
            Auth.shared.setToken(token: loginResponse.token)
        } catch {
            errorMsg = "\(error)"
        }
    }
    
    func signup(_ first_name: String, _ last_name: String, _ email: String, _ password:String) async {
        do {
            errorMsg = ""
            var signupRequest = SignupRequest(first_name: first_name,
                                              email: email,
                                              password: password)
            if (last_name != "") {
                signupRequest.last_name = last_name
            }
            
            try await authService.signup(signupRequest)
            path = []
        } catch {
            errorMsg = "\(error)"
        }
    }
}
