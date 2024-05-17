//
//  HomeModel.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/23/24.
//

import Foundation

class HomeModel: ObservableObject {
    @Published var sessions: [Session] = []
    
    let sessionsService: SessionsService
    let spotsService: SpotsService
    let usersService: UsersService
    
    init(sessionsService: SessionsService, spotsService: SpotsService, usersService: UsersService) {
        self.sessionsService = sessionsService
        self.spotsService = spotsService
        self.usersService = usersService
    }
    
    func getSessions() async {
        do {
            self.sessions = try await sessionsService.getSessions()
        } catch {
            print("\(error)")
        }
    }
    
//    ** For when searching for spots is possible **
//    func createSession(_ name: String, _ start_datetime: Date, spot_id: Int) async {
//        do {
//            try await sessionsService.createSession(SessionRequest(name: name,
//                                                                   start_datetime: start_datetime,
//                                                                   spot_id: spot_id))
//            isCreatingSession = false
//        } catch {}
//    }
    
    func createSession(_ name: String, _ start_datetime: Date, _ spotRequest: SpotRequest) async {
        do {
            let spot = try await spotsService.createSpot(spotRequest)
            let session = try await sessionsService.createSession(SessionRequest(name: name,
                                                                                 start_datetime: start_datetime,
                                                                                 spot_id: spot.id))
            self.sessions.append(session)
        } catch {
            print("\(error)")
        }
    }
    
    func addUserToSession(sessionId: Int, addedUserId: Int) async -> Bool {
        do {
            try await sessionsService.addUser(sessionId: sessionId, addedUserId: addedUserId)
            return true
        } catch {
            print("\(error)")
            return false
        }
    }
    
    func getUsers(from: Session) async -> [User] {
        do {
            return try await sessionsService.getSessionUsers(sessionId: from.id)
        } catch {
            print("\(error)")
            return []
        }
    }
    
    func searchUsers(_ searchQuery: String) async -> [User] {
        do {
            return try await usersService.getUsers(searchQuery)
        } catch {
            print("\(error)")
            return []
        }
    }
}
