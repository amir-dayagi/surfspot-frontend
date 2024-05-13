//
//  UsersService.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/28/24.
//

import Foundation

enum UsersServiceError: Error {
    case badURL
}

class UsersService {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getUsers(_ searchQuery: String) async throws -> [User] {
        var components = URLComponents(string: "\(baseURL.absoluteString)/users")
        components!.queryItems = [
            URLQueryItem(name: "name", value: searchQuery)
        ]
        
        guard let url = components!.url else {
            throw UsersServiceError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)

        return try JSONDecoder().decode([User].self, from: data)
    }
}
