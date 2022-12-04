//
//  Why1Habit.swift
//  1habit
//
//  Created by Jayce Sagvold on 12/4/22.
//

import SwiftUI

struct Why1Habit: View {
    var body: some View {
        
        VStack {
            Text("Why 1Habit?")
                .font(.title)
                .bold()
                .padding(.vertical, 15)
                .padding(.bottom, 50)
            
            Text("If you write/type something down you are 42% more likely to do the task.")
                .font(.title3)
                .padding(.bottom, 15)
            
            Text("Carrer change.")
                .font(.title3)
                .padding(.bottom, 15)
            
            Text("Habit tracker helps you focus on a certain task.")
                .font(.title3)
                .padding(.bottom, 15)
            
            Text("1Habit holds you accountable.")
                .font(.title3)
                .padding(.bottom, 15)
            
            
            
            Text("1Habit holds you accountable.")
                .font(.title3)
                .padding(.bottom, 15)
            
            
            
            
            
            
            
            Spacer()
        }
    }
}

struct Why1Habit_Previews: PreviewProvider {
    static var previews: some View {
        Why1Habit()
    }
}
