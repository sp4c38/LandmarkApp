//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Léon Becker on 11.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile
    
    let goalFormatter: DateFormatter = { // no computed variable
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }() // <--
    
    var body: some View {
        List {
            Text(profile.username)
                .font(.title)
                .bold()
            
            Text("Notifications: \(profile.prefersNotification ? "On" : "Off")")
            Text("Seasonal Photos: \(self.profile.seasonalPhoto.rawValue)")
            Text("Goal Date: \(profile.goalDate, formatter: goalFormatter)")
        }
    }
}

struct ProfileHost: View {
    @State var draftProfile = Profile.default
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            ProfileSummary(profile: draftProfile)
        }
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(UserData())
    }
}
