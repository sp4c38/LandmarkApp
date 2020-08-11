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
        ("Heart Rate", \Hike.Observation.heartRate),
        ("Pace", \Hike.Observation.pace),
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
                            .font(.system(size: 15))
                            .foregroundColor(value.1 == dataToShow ?
                                Color.gray :
                                Color.accentColor)
                            .animation(nil)
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
