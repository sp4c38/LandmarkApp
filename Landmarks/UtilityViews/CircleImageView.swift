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
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 3))
                .shadow(radius: 10)
        }
    }
}
