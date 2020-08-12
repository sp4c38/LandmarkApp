//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Léon Becker on 11.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct settingInfoView: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack() {
            Text(key)
                .bold()
                .font(.system(size: 19))
                
            Spacer()
            
            Text(value)
                .bold()
                .font(.system(size: 19))
        }
        .foregroundColor(Color.white)
        .padding(7)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.6000, saturation: 0.5001, brightness: 0.8743), Color(hue: 0.6000, saturation: 0.5001, brightness: 0.5616)]), startPoint: .topLeading, endPoint: .topTrailing))
        .shadow(radius: 10)
        .cornerRadius(10)
        .shadow(radius: 4)
        .overlay(
            RoundedRectangle(
                cornerRadius: 10
            )
            .stroke(Color.black, lineWidth: 1)
        )
        .frame(maxWidth: 250)
    }
}

struct ProfileSummary: View {
    var profile: Profile
    
    let goalFormatter: DateFormatter = { // no computed variable
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }() // <--
    
    var body: some View {
        VStack(alignment: .center, spacing: 35) {
            ZStack { // Stack for Username Section
                RoundedRectangle(cornerRadius: 100)
                    .fill(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .topTrailing))
                    .frame(width: 300, height: 60)
                
                Text(profile.username)
                    .font(.title)
                    .bold()
                    .shadow(color: Color.black, radius: 2, x: 3, y: 1)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 10) { // Stack for Settings Section
                settingInfoView(key: "Notifications:", value: profile.prefersNotification ? "On" : "Off")
                settingInfoView(key: "Seasonal Photo:", value: profile.seasonalPhoto.rawValue)
                settingInfoView(key: "Goal Date:", value: goalFormatter.string(from: profile.goalDate))
            }
            
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
            
            VStack(alignment: .leading) { // Stack for "Recent Hikes" section
                Text("Recent Hikes")
                    .font(.headline)
            
                HikeView(hike: allHikes[0])
            }

            Spacer()
            
        }
        .padding()
        .animation(.easeIn(duration: 0.3))
    }
}

struct ProfileHost: View {
    @State var draftProfile = Profile.default
    @EnvironmentObject var userData: UserData
    @Environment(\.editMode) var mode
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                EditButton()
            } .padding(.trailing, 10)
            
            if self.mode.wrappedValue == .inactive {
                ProfileSummary(profile: draftProfile)
            } else {
                Text("Profile editor")
            }
        }
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(UserData())
    }
}
