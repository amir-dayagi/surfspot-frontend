//
//  SessionView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/23/24.
//

import SwiftUI
import MapKit

struct SessionView: View {
    @State var session: Session
    
    @Environment(\.dismiss) private var dismiss
    
    func getSessionSpotInitialPosition() -> MapCameraPosition {
        return MapCameraPosition.region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: session.spot.latitude,
                                           longitude: session.spot.longitude),
            span: MKCoordinateSpan(latitudeDelta: 1,
                                   longitudeDelta: 1))
        )
    }
    
    func getSessionSpotCircle() -> MapCircle {
        return MapCircle(center: CLLocationCoordinate2D(latitude: session.spot.latitude,
                                                        longitude: session.spot.longitude),
                         radius: session.spot.radius)
    }
    
    var body: some View {
        NavigationStack {
            Map(initialPosition: getSessionSpotInitialPosition()) {
                getSessionSpotCircle()
                    .stroke(.black.opacity(0.6), lineWidth: 5)
                    .foregroundStyle(.red.opacity(0.6))
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.blue)
                }
            }
            
            ToolbarItem(placement: .principal) {
                NavigationLink {
                    SessionInfoView(session: session)
                } label: {
                    VStack {
                        Text(session.name)
                            .font(.headline)
                            
                        Image(systemName: "chevron.forward")
                            .font(.footnote)
                    }
                }
            }
        }
        .toolbarBackground(.white.opacity(0.6), for: .automatic)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationStack {
        SessionView(session: Session(id: 1,
                                     create_datetime: Date.now,
                                     name: "Session Name!",
                                     start_datetime: Date.now,
                                     spot: Spot(id: 1,
                                                name: "Spot Name!",
                                                latitude: 51.507222,
                                                longitude: -0.1275,
                                                radius: 10000)))
    }
}
