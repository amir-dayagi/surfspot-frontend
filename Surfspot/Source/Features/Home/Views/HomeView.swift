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
            ScrollView {
                VStack (alignment: .leading, spacing: 15) {
                    ForEach(homeModel.sessions, id: \.self) { session in
                        NavigationLink {
                            SessionView(session: session)
                        } label: {
                            SessionListItem(session: session)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Logout") {
                        auth.logout()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Surfspot")
                        .bold()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CreateSessionView()
                    } label: {
                        Image(systemName: "plus")
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
