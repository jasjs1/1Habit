//
//  StreakVIew.swift
//  OneHabit
//
//  Created by Jayce Sagvold on 6/26/23.
//

import SwiftUI

struct StreakView: View {
    @State private var streak: Int = 0
    
    var body: some View {
        VStack {
            Text("\(streak)")
                .font(.system(size: 275))
                .foregroundColor(Color.yellow)
                .font(.system(size: 14, design: .rounded))
            
            Text("Current Running Streak")
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(.secondary)
                .bold()
            Text("(by days)")
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(.secondary)
                .bold()
        }
        .onAppear {
            fetchStreak()
        }
    }
    
    func fetchStreak() {
        if let fetchedStreak = UserDefaults.standard.value(forKey: "Streak") as? Int {
            streak = fetchedStreak
        }
    }
}

struct StreakView_Previews: PreviewProvider {
    static var previews: some View {
        StreakView()
    }
}
    
