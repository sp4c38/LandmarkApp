//
//  CircleImageView.swift
//  Landmarks
//
//  Created by Léon Becker on 29.07.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct CircleImageView: View {
    var image: Image
    
    var body: some View {
        VStack {
            image
                .resizable()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 3))
                .shadow(radius: 10)
        }
    }
}



struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(image: Image("charleyrivers.jpg"))
            .previewLayout(.fixed(width: 300, height: 300))
            .scaleEffect(6)
    }
}
