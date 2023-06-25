//
//  OneHabitApp.swift
//  OneHabit
//
//  Created by Jayce Sagvold on 6/24/23.
//

import SwiftUI

@main
struct OneHabitApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Habits", systemImage: "calendar")
                    }
                CreateHabit()
                    .tabItem {
                        Label("Create Habit", systemImage: "square.and.pencil")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
