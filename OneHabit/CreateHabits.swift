//
//  CreateHabit.swift
//  OneHabit
//
//  Created by Jayce Sagvold on 6/25/23.
//


import SwiftUI

struct MyHabit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var selectedDays: [String]
    var streakCount: Int
    var notificationTime: Date?
}

struct CreateHabit: View {
    @State private var habits: [MyHabit] = []
    @State private var isAddingHabit = false
    @State private var newHabitName = ""
    @State private var newHabitDays = [String]()
    @State private var newHabitReminderTime = Date()
    @State private var isShowingBottomSheet = false
    
    var body: some View {
        VStack {
            Text("Create habits that actually stick")
                .font(.title2)
                .bold()
            
            Spacer().frame(height: 20) // Adds 20 points of vertical spacing
            
            Image("AddHabitImage")
                .resizable()
                .frame(width: 320, height: 320)
                .cornerRadius(20)
            
            Text("Every new year we make goals. Most people quit before January ends. Only 9% of people continue with them.")
                .padding()
            
            Button(action: {
                isShowingBottomSheet = true
            }) {
                Text("Become a part of the 9%")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .font(.title3)
                    .bold()
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingBottomSheet) {
                BottomSheetView(isShowingBottomSheet: $isShowingBottomSheet)
            }
        }
    }
}

struct BottomSheetView: View {
    @Binding var isShowingBottomSheet: Bool
    @State private var newHabitName = ""
    @State private var newHabitReminderTime = Date()
    @State private var newHabitDays = [String]()
    @State private var savedHabits: [MyHabit] = []
    
    var body: some View {
        VStack {
            TextField("Habit Name", text: $newHabitName)
                .border(.black)
                .padding(21)
            
            Text("Select the days you want to practice the habit")
                .font(.callout)
            
            Toggle("Monday", isOn: bindingForDay("Monday"))
            Toggle("Tuesday", isOn: bindingForDay("Tuesday"))
            Toggle("Wednesday", isOn: bindingForDay("Wednesday"))
            Toggle("Thursday", isOn: bindingForDay("Thursday"))
            Toggle("Friday", isOn: bindingForDay("Friday"))
            Toggle("Saturday", isOn: bindingForDay("Saturday"))
            Toggle("Sunday", isOn: bindingForDay("Sunday"))
            
            DatePicker("Reminder time:", selection: $newHabitReminderTime, in: ...Date())
            
        }
        .padding()
        .navigationBarTitle("New Habit")
        
        Button(action: {
            let newHabit = MyHabit(name: newHabitName, selectedDays: newHabitDays, streakCount: 0, notificationTime: newHabitReminderTime)
            savedHabits.append(newHabit)
            saveHabitsToStorage(savedHabits)
            isShowingBottomSheet = false
        }) {
            VStack {
                Text("Add Habit!")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .font(.title3)
                    .bold()
                    .cornerRadius(10)
                
                Text("You will get notified based on the days that you inputted and the time that you have inputted.")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .padding(5)
                
                Button(action: {
                    
                }) {
                    Text("Close")
                        .padding(12)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .font(.callout)
                        .bold()
                        .cornerRadius(10)
                }
            }
        }
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: "SavedHabits") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([MyHabit].self, from: data) {
                    savedHabits = decoded
                }
            }
        }
    }
    
    func saveHabitsToStorage(_ habits: [MyHabit]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "SavedHabits")
        }
    }
    
    func bindingForDay(_ day: String) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                newHabitDays.contains(day)
            },
            set: {
                if $0 {
                    newHabitDays.append(day)
                } else {
                    newHabitDays.removeAll { $0 == day }
                }
            }
        )
    }
}

struct CreateHabit_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabit()
    }
}
