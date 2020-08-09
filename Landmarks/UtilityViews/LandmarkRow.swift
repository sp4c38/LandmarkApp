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
    
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.trailing, 14)
            
            Text(landmark.name)
                .padding(.top, 5)
                .padding(.trailing, 16)
                .padding(.bottom, 5)
            
            Spacer()
            
            Button(action: {
                self.userData.landmarks[self.landmarkIndex].isFavorite.toggle()
            }) {
                if landmark.isFavorite {
                    Image(systemName: "star.fill")
                        .imageScale(.medium)
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .imageScale(.medium)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group { // Return multiple previews
            LandmarkRow(landmark: allLandmarks[2])
            LandmarkRow(landmark: allLandmarks[4])
        }.previewLayout(.fixed(width: 400, height: 70))
        LandmarkList()
            .environmentObject(UserData())
    }
}
