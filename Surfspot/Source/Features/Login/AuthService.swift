//
//  AuthService.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/24/24.
//

import Foundation

enum AuthServiceError: Error {
    case badURL
    case badRequest
}

class AuthService {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func login(_ loginRequest: LoginRequest) async throws -> LoginResponse {
        guard let url = URL(string: "/login", relativeTo: baseURL) else {
            throw AuthServiceError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(loginRequest)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
    
    func signup(_ signupRequest: SignupRequest) async throws -> Void {
        guard let url = URL(string: "/signup", relativeTo: baseURL) else {
            throw AuthServiceError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(signupRequest)
        
        let _ = try await URLSession.shared.data(for: request)
    }
}
