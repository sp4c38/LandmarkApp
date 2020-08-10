//
//  HikeGraph.swift
//  Landmarks
//
//  Created by Léon Becker on 10.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

func rangeOfRanges<C: Collection>(ranges: C) -> Range<Double>
    where C.Element == Range<Double> {

    guard !ranges.isEmpty else { return 0..<0 }
    let low = ranges.lazy.map { $0.lowerBound }.min()! // each element is parsed to the { } declaration. $0 is the element parsed
    let high = ranges.lazy.map { $0.upperBound }.max()!
    
    return low..<high // ..< defines a range which goes from a to b but doesn't include b
                      // for example: 0...4 would result into the range: 0,1,2,3,4
                      //              0..<4 would result into the range: 0,1,2,3
}

func magnitude(of range: Range<Double>) -> Double {
    return range.upperBound - range.lowerBound
}

struct HikeGraph: View {
    var hike: Hike
    var path: KeyPath<Hike.Observation, Range<Double>>
    
    var color: Color {
        switch path {
            case \.elevation:
                return Color.gray
            case \.heartRate:
                return Color(hue: 0, saturation: 0.5, brightness: 0.7)
            case \.pace:
                return Color(hue: 0.7, saturation: 0.4, brightness: 0.7)
            default:
                return .black
        }
    }
    
    var body: some View {
        /*
         magnitude: the height of a certain column
         maxMagnitude: the tallest magnitude
         overallRange: the range from the lowest starting point of all columns to the topmost upper point of all columns
         */
        
        
        let data = hike.observations
        let overallRange = rangeOfRanges(ranges: data.lazy.map { $0[keyPath: path] }) // keyPath in Swift is a reference to a attribute of a object. Here to the Range in an hike.observations element.
        
        let maxMagnitude = data.map { magnitude(of: $0[keyPath: path]) }.max()!
        let magnitudeOverallRange = magnitude(of: overallRange)
        let heightRatio = (1.00 - CGFloat(maxMagnitude / magnitudeOverallRange)) / 2
        
        return GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                ForEach(data.indices) { index in // data.indices gets the amount of items in the data list but as ClosedRange (Range) from first item until last item
                    GraphCapsule(
                        index: index, // Index of the element (path) in the data list
                        height: proxy.size.height, // The total height of the graph view
                        range: data[index][keyPath: self.path], // Range of the magnitude of a single column
                        overallRange: overallRange // Rrange from the lowest to the heighest point in the column graph
                    )
                    .colorMultiply(color)
                }
                .offset(x: 0, y: proxy.size.height * heightRatio)
            }
        }
    }
}

struct HikeGraph_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HikeGraph(hike: allHikes[0], path: \.elevation)
        }
    }
}
