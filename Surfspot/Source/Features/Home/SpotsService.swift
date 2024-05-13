//
//  SpotsService.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/26/24.
//

import Foundation

enum SpotsServiceError: Error {
    case badURL
}

class SpotsService {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func createSpot(_ spotRequest: SpotRequest) async throws -> Spot {
        guard let url = URL(string: "/spots", relativeTo: baseURL) else {
            throw SpotsServiceError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(spotRequest)

        let (data, _) = try await URLSession.shared.data(for: request)

        return try JSONDecoder().decode(Spot.self, from: data)
    }
}
