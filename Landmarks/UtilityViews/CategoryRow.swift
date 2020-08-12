//
//  CategoryRow.swift
//  Landmarks
//
//  Created by Léon Becker on 11.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark
    
    var body: some View {
        VStack() {
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(6)
            VStack(alignment: .center) {
                Text(landmark.name)
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
        .padding(.leading, 15)
    }
}

struct CategoryRow: View {
    var rowLandmarks: [Landmark]
    var categoryName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 12)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(rowLandmarks) { landmark in
                        NavigationLink(destination: LandmarkInfo(with: landmark)) {
                            CategoryItem(landmark: landmark)
                        }
                    }
                }.frame(height: 185)
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            rowLandmarks: Array(allLandmarks.prefix(3)), // prefix will get the first 5 items out of the allLandmarks array
            categoryName: allLandmarks[0].category.rawValue
        )
    }
}
