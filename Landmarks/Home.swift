//
//  CategoryHome.swift
//  Landmarks
//
//  Created by Léon Becker on 11.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    @State var showProfile: Bool = false
    
    var categories: [String: [Landmark]] {
        Dictionary ( // Groups all elements in allLandmarks by the category of the element
            grouping: allLandmarks,
            by: { $0.category.rawValue }
        )
    }
    
    var featured: [Landmark] {
        allLandmarks.filter { $0.isFeatured }
    }
    
    var profileButton: some View {
        Button(action: {
            self.showProfile.toggle()
        }) {
            Image(systemName: "person.crop.circle")
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
    let impact = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        NavigationView() {
            List {
                FeaturedLandmarks(landmarks: featured)
                    .listRowInsets(EdgeInsets())

                ForEach(categories.keys.sorted(), id: \.self) { cate in
                    CategoryRow(
                        rowLandmarks: categories[cate]!,
                        categoryName: cate
                    )
                }.listRowInsets(EdgeInsets())
                
                NavigationLink(destination: LandmarkList()) {
                    Text("See all")
                }
            }
            .navigationBarTitle("Featured")
            .navigationBarItems(trailing: profileButton)
        }
        .sheet(isPresented: $showProfile) {
            ProfileHost()
                .onAppear(perform: {
                    impact.impactOccurred()
                })
        }
    }
}

struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    
    var body: some View {
        VStack {
            landmarks[0].image
                .resizable()
                .scaledToFill()
        }
        .frame(height: 200)
        .clipped()

    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
