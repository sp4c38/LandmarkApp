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
        VStack {
            List() {
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Favorites only")
                }
            
                ForEach(userData.landmarks) { landmark in // This will identify each element in allLandmarks by its id which is already stored in each class
                    if landmark.isFavorite || !(userData.showFavoritesOnly) {
                        NavigationLink(destination: LandmarkInfo(with: landmark)){
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0)) // Needed that list collapses correctly when views disappear
            .navigationBarTitle("Landmarks")
            .transition(AnyTransition.opacity)
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            LandmarkList()
                .environmentObject(UserData())
        }
    }
}
