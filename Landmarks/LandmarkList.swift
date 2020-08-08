//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Léon Becker on 08.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationView {
            List(allLandmarks) { landmark in // This will identify each element in  allLandmarks by its id which is already stored in each class
                NavigationLink(destination: LandmarkInfo(with: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }.navigationBarTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}
