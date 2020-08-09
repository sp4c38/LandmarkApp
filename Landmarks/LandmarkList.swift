//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Léon Becker on 08.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List() {
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(userData.landmarks) { landmark in // This will identify each element in  allLandmarks by its id which is already stored in each class
                    HStack() {
                        if landmark.isFavorite || !(userData.showFavoritesOnly) {
                            VStack(alignment: .leading) {
                                NavigationLink(destination: LandmarkInfo(with: landmark)){
                                    LandmarkRow(landmark: landmark)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(UserData())
    }
}
