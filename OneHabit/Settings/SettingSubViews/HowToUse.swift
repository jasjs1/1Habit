//
//  HowToUseApp.swift
//  OneHabit
//
//  Created by Jayce Sagvold on 6/30/23.
//

import SwiftUI

struct HowToUseApp: View {
    var body: some View {
        List {
            Section(header: Text("Habit resources")) {
                Text("Creating a Habit")
                    .bold()
                    .font(.title3)
                Text("To create a Habit, go to the 'Create Habit' tab. Then fill out the forms, and press the Create Habit button.")
                
                Text("Deleting a Habit")
                    .bold()
                    .font(.title3)
                Text("Before you do so, make sure you are sure that you would like do delete this Habit, because you will not be able to get it back. Go to Settings, look for the Habit Information, under the Habit Resources section.")
            }
            
            Section(header: Text("General Resources")) {
                Text("Creating an Account")
                    .bold()
                    .font(.title3)
                Text("At this moment, there is no diffrence of using 1Habit without a account. But in the feature there may be some changes.")
                
                Text("Why 1Habit?")
                    .bold()
                    .font(.title3)
                
                Text("1Habit is a simple app to use. And this adds value to your life day by day.")
            }
        }
    }
}

struct HowToUseApp_Previews: PreviewProvider {
    static var previews: some View {
        HowToUseApp()
    }
}
