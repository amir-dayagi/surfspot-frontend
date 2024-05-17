//
//  HomeView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 5/12/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeModel: HomeModel
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        NavigationStack {
            HStack {
                Button("Logout") {
                    auth.logout()
                }
                
                Spacer()
                
                NavigationLink {
                    CreateSessionView()
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            List() {
                ForEach(homeModel.sessions, id: \.self) { session in
                    NavigationLink {
                        SessionView(session: session)
                    } label: {
                        Text(session.name)
                    }
                }
            }
        }
        .task {
            await homeModel.getSessions()
        }
    }
}

//#Preview {
//    HomeView()
//}
