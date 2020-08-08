//
//  Landmark.swift
//  Landmarks
//
//  Created by Léon Becker on 07.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import MapKit
import SwiftUI

// Create a new structure which stores data for a landmark

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var state: String
    var park: String
    var category: Category
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case lake = "Lakes"
        case rivers = "Rivers"
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
