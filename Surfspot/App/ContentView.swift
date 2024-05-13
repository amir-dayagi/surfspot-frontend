//
//  ContentView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 3/24/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        if (auth.loggedIn) {
            HomeView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LoginModel(AuthService(baseURL: URL(string: "http://127.0.0.1:5000")!)))
        .environmentObject(HomeModel(sessionsService: SessionsService(baseURL: URL(string: "http://127.0.0.1:5000")!),
                                     spotsService: SpotsService(baseURL: URL(string: "http://127.0.0.1:5000")!),
                                     usersService: UsersService(baseURL: URL(string: "http://127.0.0.1:5000")!)))
        .environmentObject(Auth.shared)
}
