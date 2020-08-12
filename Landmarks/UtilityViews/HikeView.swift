//
//  HikeView.swift
//  Landmarks
//
//  Created by Léon Becker on 10.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .scale)
            .combined(with: .move(edge: .bottom))
            .combined(with: .opacity)
        
        let removal = AnyTransition.scale
            .combined(with: .scale)
            .combined(with: .move(edge: .bottom))
            .combined(with: .opacity)
        
        return asymmetric(insertion: insertion, removal: removal)
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false

    let impact = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 20)
                    .offset(y: 5)
                
                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }
            
                Spacer()
            
                Button(action: {
                    impact.impactOccurred()
                    self.showDetail.toggle()
                    //}
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.3 : 1.0)
                        .padding(20)
                }
            }
            
            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade) // By default a view fades in and out when it appears or is removed (transition). With the .transition method the transition can be modified
                    .animation(.ripple())
            }
        }
        .padding().padding(.bottom, -16) // Add padding to all edges except of the bottom
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        HikeView(hike: allHikes[0])
            .animation(.easeIn(duration: 0.5))
    }
}
