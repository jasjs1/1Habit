//
//  _habitApp.swift
//  1habit
//
//  Created by Jayce Sagvold on 12/4/22.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                
                HomeScreen()
                    .tabItem {
                        Label("Habits", systemImage: "house")
                        
                    }
                
                
                Why1Habit()
                    .tabItem {
                        Label("Why 1 Habit", systemImage: "questionmark.folder.fill")
                    }
            }
        }
    }
}
