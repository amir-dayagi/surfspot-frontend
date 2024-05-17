//
//  SessionInfoView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 5/12/24.
//

import SwiftUI

func getFullName(of: User) -> String {
    return of.last_name != "" ? "\(of.first_name) \(of.last_name)" : of.last_name
}

struct SessionInfoView: View {
    @EnvironmentObject var homeModel: HomeModel
    @State var session: Session
    @State var sessionUsers: [User] = []
    
    @State var isAddPresented = false
    
    var body: some View {
        Text(session.name)
        
        Text("Users:")
        List {
            ForEach(sessionUsers, id: \.self) { user in
                Text(getFullName(of: user))
            }
        }
        .task {
            sessionUsers = await homeModel.getUsers(from: session)
        }
        
        Button("Add User") {
            isAddPresented = true
        }.popover(isPresented: $isAddPresented) {
            AddMenu(session: session, isAddPresented: $isAddPresented)
        }
    }
}

struct AddMenu: View {
    @EnvironmentObject var homeModel: HomeModel
    @State var session: Session
    @Binding var isAddPresented: Bool
    
    @State var searchText = ""
    @State var users: [User] = []
    @State var selectedUser: User?
    @State var addErrorMsg = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.self) { user in
                    Text(getFullName(of: user))
                        .onTapGesture {
                            if selectedUser != user {
                                selectedUser = user
                            } else {
                                selectedUser = nil
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(user==selectedUser ? .gray : .white)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                Task {
                    users = await homeModel.searchUsers(searchText)
                }
            }
            
            if addErrorMsg != "" {
                Text(addErrorMsg)
            }
            
            Button("Add") {
                Task {
                    addErrorMsg = ""
                    if let addedUser = selectedUser {
                        if !(await homeModel.addUserToSession(sessionId: session.id, addedUserId: addedUser.id)) {
                            addErrorMsg = "Unable to add user, try again later!"
                        }
                    } else {
                        addErrorMsg = "Please select a user to add first!"
                    }
                }
            }
        }
    }
}

//#Preview {
//    SessionInfoView()
//}
