//
//  MapView.swift
//  Landmarks
//
//  Created by Léon Becker on 29.07.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        let landmark_map: MKMapView {
            MKMapView(frame: .zero)
        }
        landmark_map.isZoomEnabled = false
        landmark_map.isScrollEnabled = false

        return landmark_map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinates = CLLocationCoordinate2D(
            latitude: 33.869007,
            longitude: -115.837808
        )
        let span = MKCoordinateSpan(
            latitudeDelta: 2.0,
            longitudeDelta: 2.0
        )
        let region = MKCoordinateRegion(center: coordinates, span: span)
        uiView.setRegion(region, animated:true)
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
