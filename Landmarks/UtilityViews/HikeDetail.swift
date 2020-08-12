//
//  HikeDetail.swift
//  Landmarks
//
//  Created by Léon Becker on 11.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct HikeDetail: View {
    var hike: Hike
    @State var dataToShow = \Hike.Observation.elevation // The \ (back slash) will create a key path to the elevation Observation
    
    var buttons = [
        ("Elevation", \Hike.Observation.elevation),
        ("Pace", \Hike.Observation.pace),
        ("Heart Rate", \Hike.Observation.heartRate),
    ]
    
    var body: some View {
        VStack(spacing: -10) {
            HikeGraph(hike: hike, path: dataToShow)
                .frame(height: 200)
                .padding()
            
            HStack(spacing: 50) {
                ForEach(buttons, id: \.0) { value in
                    Button(action: {
                        self.dataToShow = value.1
                    }) {
                        Text(value.0)
                            .font(.headline)
                            .bold()
                            .foregroundColor(value.1 == dataToShow ?
                                Color.gray :
                                Color.black)
                    }
                }
            }
        }
    }
}

struct HikeDetail_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetail(hike: allHikes[0])
        HikeView(hike: allHikes[0])
    }
}
