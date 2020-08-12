//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Léon Becker on 11.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct ProfileSummary: View {
    @Binding var profile: Profile
    var editModeEnabled: Bool
    
    let goalFormatter: DateFormatter = { // no computed variable
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }() // <--
    
    var body: some View {
        VStack(alignment: .center, spacing: 26) {
            if !editModeEnabled {
                ZStack { // Stack for Username Section
                    RoundedRectangle(cornerRadius: 100)
                        .fill(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .topTrailing))
                        .frame(width: 300, height: 60)
                    
                    Text(profile.username)
                        .foregroundColor(.white)
                        .bold()
                      .font(.title)

                }
                .frame(maxWidth: .infinity)
            }
            
            if !editModeEnabled {
                Divider()
                
                VStack(alignment: .leading) { // Stack for "Recent Hikes" section
                    Text("Recent Hikes")
                        .font(.headline)
                
                    HikeView(hike: allHikes[0])

                }

                Divider()
                
                VStack(alignment: .leading) { // Stack for "Completed Badges" Section
                    Text("Completed Badges")
                        .font(.headline)
                
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            HikeBadge(name: "First Hike")
                            HikeBadge(name: "Earth Day")
                                .hueRotation(Angle(degrees: 250))
                            HikeBadge(name: "Tenth Hike")
                                .hueRotation(Angle(degrees: 395))
                        }
                    }
                }
            }
            
            VStack(spacing: editModeEnabled ? 40 : 20) { // Stack for Settings Section
                if editModeEnabled {
                    ProfileSettingsView(key: "Name:", value: profile.username, editModeEnabled: editModeEnabled, profile: $profile)
                }
                ProfileSettingsView(key: "Notifications:", value: profile.prefersNotification ? "On" : "Off", editModeEnabled: editModeEnabled, profile: $profile)
                ProfileSettingsView(key: "Seasonal Photo:", value: profile.seasonalPhoto.rawValue, editModeEnabled: editModeEnabled, profile: $profile)
            }

            Spacer()
        }
        .padding(16)
    }
}

struct ProfileHost: View {
    @State var editModeEnabled: Bool = false
    @EnvironmentObject var userData: UserData

    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Button(action: { // The edit button
                editModeEnabled.toggle()

            }) {
                if editModeEnabled {
                    Text("Done")
                } else if !editModeEnabled {
                    Text("Edit")
                }
            }
            .padding(.trailing, 10)
            .padding(.bottom, 10)
            
            ProfileSummary(profile: $userData.profile, editModeEnabled: editModeEnabled)

            
        }
        .animation(.easeIn(duration: 0.5))
        .padding(.trailing, 10)
        .padding(.top, 20)
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(UserData())
    }
}
