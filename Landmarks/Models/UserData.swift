//
//  UserData.swift
//  Landmarks
//
//  Created by Léon Becker on 09.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly: Bool = false
    @Published var landmarks = allLandmarks
    @Published var profile = Profile.default
    @Published var lolkgkj: Bool = false
}
