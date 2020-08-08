//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Léon Becker on 07.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct LandmarkRow: View {
    //var landmark: Landmark // Entry for a single Landmark
    var landmarkData: Landmark

    
    var body: some View {
        HStack {
            landmarkData.image
                .resizable()
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(landmarkData.name)
            Spacer()
        }.padding()
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group { // Return multiple previews
            LandmarkRow(landmarkData: allLandmarks[1])
                .previewLayout(.fixed(width: 400, height: 70))
        }
    }
}
