//
//  ButtonStyles.swift
//  Landmarks
//
//  Created by Léon Becker on 09.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct FavoriteButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Color(hue: 1.0000, saturation: 0.7553, brightness: 1.0000))
            .cornerRadius(4)
            .shadow(radius: 12)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct RecenterButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Color(hue: 0.5779, saturation: 1.0000, brightness: 0.9647))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 6)
            )
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding()
            .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
            .blur(radius: configuration.isPressed ? CGFloat(0.0) : 0)
            .animation(Animation.spring(response: 0.25, dampingFraction: 0.3, blendDuration: 1))
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        LandmarkInfo(with: allLandmarks[3])
            .environmentObject(UserData())
    }
}
