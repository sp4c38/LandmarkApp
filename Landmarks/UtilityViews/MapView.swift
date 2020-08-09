//
//  MapView.swift
//  Landmarks
//
//  Created by Léon Becker on 29.07.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI
import MapKit

func collides(span: MKCoordinateSpan,coordinates: CLLocationCoordinate2D, with point: CLLocationCoordinate2D) -> Bool {
    var longitude_collides = false
    var latitude_collides = false
    
    if (point.longitude >= (coordinates.longitude - (span.longitudeDelta / 2))) && (point.longitude <= (coordinates.longitude + (span.longitudeDelta / 2))) {
        longitude_collides = true
    }
    
    if (point.latitude <= (coordinates.latitude + (span.latitudeDelta / 2))) && (point.latitude >= (coordinates.latitude - (span.latitudeDelta / 2))) {
        latitude_collides = true
    }
    
    if longitude_collides && latitude_collides {
        return true
    } else {
        return false
    }
}

struct MapView: UIViewRepresentable {
    var data: InfoData
    
    var region: MKCoordinateRegion { // Region which is displayed on first call which consists out of the center coordinates and the span
        MKCoordinateRegion(center: data.landmark.locationCoordinate, span: data.landmark.span)
    }
    
    // Create a Coordinator which is needed to connect a UIView instance to SwiftUI
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            if collides(span: parent.data.landmark.span,
                        coordinates: parent.data.landmark.locationCoordinate,
                        with: mapView.centerCoordinate) {
                parent.data.isCentered = true
            } else {
                parent.data.isCentered = false
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
 
    func makeUIView(context: Context) -> MKMapView {
        data.map.isZoomEnabled = true
        data.map.isScrollEnabled = true
        data.map.isPitchEnabled = true
        data.map.isRotateEnabled = true
        data.map.delegate = context.coordinator
        
        return data.map
    }
    
    // The "_" tells swift that the following argument is a positional argument and no keyword argument
    func updateUIView(_ mapView: MKMapView, context: Context) {
        data.map.setRegion(region, animated:true)
        
        let landmark_marker = MKPointAnnotation()
        
        landmark_marker.coordinate = data.landmark.locationCoordinate
        data.map.addAnnotation(landmark_marker)
    }
}
