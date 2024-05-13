//
//  SessionsService.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/23/24.
//

import Foundation


enum SessionsServiceError: Error {
    case badURL
    case missingAuth
}

class SessionsService {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getSessions() async throws -> [Session] {
        guard let url = URL(string: "/sessions", relativeTo: baseURL) else {
            throw SessionsServiceError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Auth.shared.getToken()!)", forHTTPHeaderField: "Authorization")
        
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Session].self, from: data)
    }
    
    func createSession(_ sessionRequest: SessionRequest) async throws -> Session {
        guard let url = URL(string: "/sessions", relativeTo: baseURL) else {
            throw SessionsServiceError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Auth.shared.getToken()!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try encoder.encode(sessionRequest)

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Session.self, from: data)
    }
}
