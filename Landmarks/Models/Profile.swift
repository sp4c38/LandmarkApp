//
//  Profile.swift
//  Landmarks
//
//  Created by Léon Becker on 11.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotification: Bool
    var seasonalPhoto: Season

    // default is a keyword in Swift. To ignore that keyword the two `` are needed.
    static let `default` = Self(username: "sp4c38", prefersNotification: true, seasonalPhoto: .spring)
    
    init(username: String, prefersNotification: Bool = true, seasonalPhoto: Season = .spring) {
        self.username = username
        self.prefersNotification = prefersNotification
        self.seasonalPhoto = seasonalPhoto
    }
    
    enum Season: String, CaseIterable {
        case spring = "🌷"
        case summer = "☀️"
        case autumn = "🍁"
        case winter = "❄️"
    }
}
