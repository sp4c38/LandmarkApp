//
//  HikeView.swift
//  Landmarks
//
//  Created by Léon Becker on 10.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct HikeView: View {
    var hike: Hike

    var body: some View {
        Text(hike.distanceText)
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        HikeView(hike: allHikes[2])
    }
}
