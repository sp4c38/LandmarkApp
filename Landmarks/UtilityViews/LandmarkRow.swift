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
    var landmark: Landmark

    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.trailing, 10)
            Text(landmark.name)
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.top, 5)
        .padding(.trailing, 16)
        .padding(.bottom, 5)
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group { // Return multiple previews
            LandmarkRow(landmark: allLandmarks[1])
            LandmarkRow(landmark: allLandmarks[3])
        }.previewLayout(.fixed(width: 400, height: 70))
        LandmarkList()
    }
}
