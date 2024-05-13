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
    
    @State var showingCreatePopover = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Button("Logout") {
                    auth.logout()
                }
                
                Spacer()
                
                Button {
                    showingCreatePopover = true
                } label: {
                    Image(systemName: "plus")
                }
                .popover(isPresented: $showingCreatePopover) {
                    CreateSessionView(showingCreatePopover: $showingCreatePopover)
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
