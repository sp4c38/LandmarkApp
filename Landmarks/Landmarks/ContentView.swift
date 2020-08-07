//
//  ContentView.swift
//  Landmarks
//
//  Created by Léon Becker on 29.07.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @ObservedObject var landmark_data = MapData()
    @State var m = true
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .top) {
                MapView(
                    landmark_data: landmark_data
                )
                    .frame(height: 500)
                 
                if landmark_data.isCentered == false {
                    Button(action: {
                        self.landmark_data.recenterMap()
                        m.toggle()
                    }) {
                        HStack(spacing: 5) {
                            Image("marker_image")
                                .resizable()
                                .scaledToFit()
                                .padding(5)
                                .foregroundColor(Color(hue: 1.0000, saturation: 0.6938, brightness: 1.0000))
                                .frame(width: 35, height: 35)

                            Text("Re-Center")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)

                        }
                        .offset(x: -4)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(RecenterButton())
                    .offset(y: 34)
                    .transition(.asymmetric(insertion: .slide, removal: AnyTransition.opacity.animation(.easeOut)))
                }
            }
            
            CircleImageView()
                .offset(y: -102)
                .padding(.bottom, -90) // Add a little space to make space for the description beneath
            
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                
                HStack {
                    Text("Joshua Tree National Park")
                    Spacer()
                    Text("California")
                }.font(.subheadline)
        
            }
            .padding(.leading, 36)
            .padding(.trailing, 36)
 
            Spacer()
            Spacer()
            
        }.edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

