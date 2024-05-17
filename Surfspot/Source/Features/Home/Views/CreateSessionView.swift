//
//  CreateSessionView.swift
//  Surfspot
//
//  Created by Amir Dayagi on 4/23/24.
//

import SwiftUI
import MapKit

struct CreateSessionView: View {
    @EnvironmentObject var homeModel: HomeModel
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var start_datetime = Date()
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    @State var isError = false
    
    @State var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )
    
    func getSpotRequest() -> SpotRequest {
        let center = CLLocation(latitude: region.center.latitude,
                                longitude: region.center.longitude)
        let circleEdge = CLLocation(latitude: center.coordinate.latitude,
                                    longitude: center.coordinate.longitude+(region.span.longitudeDelta/2*0.6))
        let radius = center.distance(from: circleEdge)
        
        return SpotRequest(name: name + " spot",
                           latitude: center.coordinate.latitude,
                           longitude: center.coordinate.longitude,
                           radius: radius)
    }
    
    var body: some View {
        TextField("Name", text: $name)
        DatePicker("Date", selection: $start_datetime)
        GeometryReader { proxy in
            ZStack {
                Circle()
                    .stroke(.black, lineWidth: 5)
                    .fill(.red)
                    .frame(width: proxy.size.width*0.6, height: proxy.size.height*0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Map(initialPosition: position)
                    .onMapCameraChange { mapCameraUpdateContext in
                        region = mapCameraUpdateContext.region
                    }
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
        }
        
        if isError {
            Text("WTF??")
        }
        
        Button("Create!") {
            Task {
                await homeModel.createSession(name, start_datetime, getSpotRequest())
                dismiss()
            }
        }
    }
}

//#Preview {
//    CreateSessionView()
//}
