//
//  HikeView.swift
//  Landmarks
//
//  Created by Léon Becker on 10.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false

    var body: some View {
        HStack {
            HikeGraph(hike: hike, path: \.elevation)
                .frame(width: 50, height: 50)
                .animation(nil)
            
            VStack(alignment: .leading) {
                Text(hike.name)
                    .font(.headline)
                Text(hike.distanceText)
            }
            
            Spacer()
            
            Button(action: {
                self.showDetail.toggle()
            }) {
                Image(systemName: "chevron.right.circle")
                    .imageScale(.large)
                    .rotationEffect(.degrees(showDetail ? 90 : 0))
                    .padding()
            }
            

        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        HikeView(hike: allHikes[4])
    }
}
