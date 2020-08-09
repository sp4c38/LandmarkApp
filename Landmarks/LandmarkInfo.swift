//
//  ContentView.swift
//  Landmarks
//
//  Created by Léon Becker on 29.07.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI
import MapKit

class LandmarkData: ObservableObject {
    @Published var isCentered: Bool = true
    var map = MKMapView()
    var landmark: Landmark
    
    init(with lmark: Landmark) {
        landmark = lmark
    }
    
    func recenterMap() {
        map.setRegion(
            MKCoordinateRegion(
                center: landmark.locationCoordinate,
                span: landmark.span
            ), animated: true
        )
    }
}

struct LandmarkInfo: View {
    var landmark: Landmark
    @ObservedObject var data: LandmarkData
    
    init(with lmark: Landmark) {
        landmark = lmark
        data = LandmarkData(with: landmark)
    }
        
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                MapView(
                    data: data
                )
                    .frame(height: 500)
                 
                if data.isCentered == false {
                    Button(action: data.recenterMap) {
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
                    .offset(y: 79)
                    .transition(.asymmetric(insertion: .slide, removal: AnyTransition.opacity.animation(.easeOut)))
                }
            }
            
            CircleImageView(
                image: landmark.image
            )
                .offset(y: -102)
                .padding(.bottom, -90) // Add a little space to make space for the description beneath
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }.font(.subheadline)
        
            }
            .padding(.leading, 36)
            .padding(.trailing, 36)
 
            Spacer()
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle(Text(landmark.name), displayMode: .inline)
    }
}

struct LandmarkInfo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkInfo(with: allLandmarks[3])
            LandmarkList()
        }
    }
}

