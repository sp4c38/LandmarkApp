//
//  Hike.swift
//  Landmarks
//
//  Created by Léon Becker on 10.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct Hike: Hashable, Codable, Identifiable {
    let name: String
    let id: Int
    let distance: Double
    let difficulty: Int
    var observations: [Observation]
    
    var distanceText: String {
        LengthFormatter()
            .string(fromValue: distance, unit: .kilometer)
    }
    
    struct Observation: Codable, Hashable {
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
        var distanceFromStart: Double
    }
}
