//
//  ProfileSettingsView.swift
//  Landmarks
//
//  Created by Léon Becker on 12.08.20.
//  Copyright © 2020 Léon Becker. All rights reserved.
//

import SwiftUI

struct NameTextField: View {
    @Binding var profile: Profile

    var onEditingChanged: (Bool) -> Void = { _ in }
    var onCommit: () -> Void = { }
    
    var body: some View {
        Spacer()
        
        TextField("Your username", text: $profile.username, onEditingChanged: onEditingChanged, onCommit: onCommit)
            .font(Font.headline.weight(.black))
            .multilineTextAlignment(.trailing)
        
    }
}

struct ProfileSettingsView: View {
    var key: String
    var value: String
    var editModeEnabled: Bool
    @Binding var profile: Profile
    
    var onEditingChanged: (Bool) -> Void = { _ in }
    var onCommit: () -> Void = { }
    
    var body: some View {
        HStack {
            Text(key)
                .bold()
            
            if editModeEnabled && key == "Name:" { // "Seasonal Photo:" Edit Mode
                NameTextField(profile: $profile)
                
            } else if editModeEnabled && key == "Notifications:" {
                Spacer()
                
                Toggle(isOn: $profile.prefersNotification) {
                    Text("")
                }
            } else if editModeEnabled && key == "Seasonal Photo:" { // "Seasonal Photo:" Edit Mode
                Spacer()
                Picker("", selection: $profile.seasonalPhoto) {
                    ForEach(Profile.Season.allCases, id: \.self) { season in
                        Text(season.rawValue).tag(season)
                    }
                }
                .padding(.leading, 20)
                .pickerStyle(SegmentedPickerStyle())

            } else if !editModeEnabled {
                Spacer()
                Text(value)
                    .bold()
            }
        }
        .font(.system(size: 19))
        .foregroundColor(Color.white)
        .padding(8)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.6000, saturation: 0.5001, brightness: 0.8743), Color(hue: 0.6000, saturation: 0.5001, brightness: 0.5616)]), startPoint: .topLeading, endPoint: .topTrailing))
        .cornerRadius(10)
        .shadow(radius: 4)
        .lineLimit(1) // Set the line limit to one that a profile setting doesn't expand when changing to edit mode
        .overlay(
            RoundedRectangle(
                cornerRadius: 10
            ).stroke(Color.black, lineWidth: 1)
        )

    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(UserData())
    }
}
