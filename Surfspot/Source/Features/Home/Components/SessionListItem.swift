//
//  SessionListItem.swift
//  Surfspot
//
//  Created by Amir Dayagi on 5/21/24.
//

import SwiftUI

struct SessionListItem: View {
    let session: Session
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(session.name)
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            
            HStack {
                Text(session.start_datetime, style: .date)
                    .font(.subheadline)
                
                Text(session.start_datetime, style: .time)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SessionListItem(session: Session(id: 1,
                                     create_datetime: Date.now,
                                     name: "Session Name!",
                                     start_datetime: Date.now,
                                     spot: Spot(id: 1,
                                                name: "Spot Name!",
                                                latitude: 51.507222,
                                                longitude: -0.1275,
                                                radius: 20)))
}
