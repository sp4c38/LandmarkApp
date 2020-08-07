//
//  MapView.swift
//  Landmarks
//
//  Created by Léon Becker on 29.07.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI
import MapKit

struct RecenterButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
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

class MapData: ObservableObject {
    @Published var isCentered: Bool = true
    
    let coordinates = CLLocationCoordinate2D( // Coordinates for Landmark
        latitude: 33.869007,
        longitude: -115.837808
    )
    
    let span = MKCoordinateSpan ( // Span of the Landmark Map View for correct in-out zoom
        latitudeDelta: 1.4,
        longitudeDelta: 2.0
    )
    
    let landmark_marker = MKPointAnnotation()
    
    var region: MKCoordinateRegion { // Region which is displayed on first call which consists out of the center coordinates and the span
        MKCoordinateRegion(center: coordinates, span: span)
    }
    
    let landmark_map = MKMapView()
    
    func recenterMap() {
        landmark_map.setRegion(region, animated: true) // animated must be true - otherwise the recenter button will not appear and disappear correctly
    }
}

func collides(mapData: MapData, with point: CLLocationCoordinate2D) -> Bool {
    var longitude_collides = false
    var latitude_collides = false
    
    if (point.longitude >= (mapData.coordinates.longitude - (mapData.span.longitudeDelta / 2))) && (point.longitude <= (mapData.coordinates.longitude + (mapData.span.longitudeDelta / 2))) {
        longitude_collides = true
    }
    
    if (point.latitude <= (mapData.coordinates.latitude + (mapData.span.latitudeDelta / 2))) && (point.latitude >= (mapData.coordinates.latitude - (mapData.span.latitudeDelta / 2))) {
        latitude_collides = true
    }
    
    if longitude_collides && latitude_collides {
        return true
    } else {
        return false
    }
}

struct MapView: UIViewRepresentable {
    var landmark_data: MapData
    
    // Create a Coordinator which is needed to connect a UIView instance to SwiftUI
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            if collides(mapData: parent.landmark_data, with: mapView.centerCoordinate) {
                parent.landmark_data.isCentered = true
            } else {
                parent.landmark_data.isCentered = false
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
 
    func makeUIView(context: Context) -> MKMapView {
        landmark_data.landmark_map.isZoomEnabled = true
        landmark_data.landmark_map.isScrollEnabled = true
        landmark_data.landmark_map.isPitchEnabled = true
        landmark_data.landmark_map.isRotateEnabled = true
        landmark_data.landmark_map.delegate = context.coordinator
        
        return landmark_data.landmark_map
    }
    
    // The "_" tells swift that the following argument is a positional argument and no keyword argument
    func updateUIView(_ mapView: MKMapView, context: Context) {
        landmark_data.landmark_map.setRegion(landmark_data.region, animated:true)
        
        landmark_data.landmark_marker.coordinate = landmark_data.coordinates
        landmark_data.landmark_map.addAnnotation(landmark_data.landmark_marker)
    }
}
