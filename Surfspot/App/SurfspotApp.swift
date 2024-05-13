//
//  SurfspotApp.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/24/24.
//

import SwiftUI

@main
struct SurfspotApp: App {
    var authService = AuthService(baseURL: URL(string: "http://127.0.0.1:5000")!)
    var sessionService = SessionsService(baseURL: URL(string: "http://127.0.0.1:5000")!)
    var spotsService = SpotsService(baseURL: URL(string: "http://127.0.0.1:5000")!)
    var usersService = UsersService(baseURL: URL(string: "http://128.0.0.1:5000")!)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoginModel(authService))
                .environmentObject(HomeModel(sessionsService: sessionService, spotsService: spotsService, usersService: usersService))
                .environmentObject(Auth.shared)
        }
    }
}
