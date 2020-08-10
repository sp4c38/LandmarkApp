//
//  Badge.swift
//  Landmarks
//
//  Created by Léon Becker on 10.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct Badge: View {
    let rotationCount = 8
    
    var badgeSymbol: some View {
        ForEach(0..<rotationCount) { i in
            RotatedBadgeSymbol(
                angle: .degrees(Double(i) / Double(rotationCount) * 360))
            .opacity(0.5)
        }
    }
    
    var body: some View {
        ZStack {
            BadgeBackground()
            
            GeometryReader { geometery in
                badgeSymbol
                    .scaleEffect(0.25, anchor: .top)
                    .position(x: geometery.size.width / 2.0, y: 0.75 * geometery.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
