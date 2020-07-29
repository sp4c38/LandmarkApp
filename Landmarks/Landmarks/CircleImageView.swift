//
//  CircleImageView.swift
//  Landmarks
//
//  Created by Léon Becker on 29.07.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct CircleImageView: View {
    var body: some View {
        VStack {
            Image("turtle_rock")
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 3))
                .shadow(radius: 10)
        }
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}
