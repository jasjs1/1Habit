//
//  SettingsView.swift
//  OneHabit
//
//  Created by Jayce Sagvold on 6/25/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                
                NavigationLink(destination: CreateAccount()) {
                     Text("Create Account")
                 }
                
            } .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
