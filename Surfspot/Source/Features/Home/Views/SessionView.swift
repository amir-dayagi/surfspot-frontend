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
        Text(session.name)
        
        Map(initialPosition: getSessionSpotInitialPosition()) {
            getSessionSpotCircle()
                .stroke(.black.opacity(0.6), lineWidth: 5)
                .foregroundStyle(.red.opacity(0.6))
        }
    }
}

//#Preview {
//    SessionView()
//}
