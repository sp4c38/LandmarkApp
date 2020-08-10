//
//  GraphCapsule.swift
//  Landmarks
//
//  Created by Léon Becker on 10.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

import SwiftUI

struct GraphCapsule: View {
    var index: Int
    var height: CGFloat
    var range: Range<Double>
    var overallRange: Range<Double>
    
    var heightRatio: CGFloat {
        max(CGFloat(magnitude(of: range) / magnitude(of: overallRange)), 0.15) // 0.15 is the most smallest size of a column
    }
    
    var offsetRatio: CGFloat {
        CGFloat((range.lowerBound - overallRange.lowerBound) / magnitude(of: overallRange))
    }
    
    var body: some View {
        print(-offsetRatio)
        return Capsule()
            .fill(Color.white)
            .frame(height: height * heightRatio)
            .offset(x: 0, y: height * -offsetRatio) // Invert offsetRatio because the screen y coordinate goes up the more lower you go on the screen (other than in a normal coordinate sysyem (because we don't have any))
    }
}

struct GraphCapsule_Previews: PreviewProvider {
    static var previews: some View {
        GraphCapsule(index: 0, height: 150, range: 10..<50, overallRange: 0..<100)
        HikeGraph(hike: allHikes[0], path: \.elevation)
    }
}

