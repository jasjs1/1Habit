import SwiftUI

struct MyHabit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var selectedDays: [String]
    var streakCount: Int
    var notificationTime: Date?
    var selectedTime: Date
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
                BottomSheetView(isShowingBottomSheet: $isShowingBottomSheet, savedHabits: $habits)
            }
        }
    }
}

struct BottomSheetView: View {
    @Binding var isShowingBottomSheet: Bool
    @State private var newHabitName = ""
    @State private var newHabitReminderTime = Date()
    @State private var newHabitDays = [String]()
    
    @Binding var savedHabits: [MyHabit] // Binding to the habit array in CreateHabit
    
    var body: some View {
        VStack {
            TextField("Habit Name", text: $newHabitName)
                .border(Color.black)
                .padding(21)
            
            Text("Select the days you want to practice the habit")
                .font(.callout)
            
            Toggle("Monday", isOn: bindingForDay("Mon"))
            Toggle("Tuesday", isOn: bindingForDay("Tue"))
            Toggle("Wednesday", isOn: bindingForDay("Wen"))
            Toggle("Thursday", isOn: bindingForDay("Thu"))
            Toggle("Friday", isOn: bindingForDay("Fri"))
            Toggle("Saturday", isOn: bindingForDay("Sat"))
            Toggle("Sunday", isOn: bindingForDay("Sun"))
            
            DatePicker("Reminder time:", selection: $newHabitReminderTime, in: ...Date())
        }
        .padding()
        .navigationBarTitle("New Habit")
        
        VStack {
            if savedHabits.isEmpty {
                Button(action: {
                    let newHabit = MyHabit(name: newHabitName, selectedDays: newHabitDays, streakCount: 0, notificationTime: newHabitReminderTime, selectedTime: newHabitReminderTime)
                    savedHabits.append(newHabit)
                    saveHabitsToStorage(savedHabits)
                    isShowingBottomSheet = false
                }) {
                    Text("Add Habit!")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.yellow)
                        .font(.title3)
                        .bold()
                        .cornerRadius(10)
                }
            } else {
                Text("You have 1 habit already created. You have to delete the habit to create another.")
                    .padding(24)
                    .foregroundColor(.red)
                    .bold()
                    .font(.title3)
                
            }
            
            Text("You will get notified based on the days that you inputted and the time that you have inputted.")
                .foregroundColor(.secondary)
                .font(.caption)
                .padding(5)
            
            Button(action: {
                isShowingBottomSheet = false
            }) {
                Text("X")
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .font(.callout)
                    .bold()
                    .cornerRadius(10)
            }
        }
        .disabled(!savedHabits.isEmpty)
        .opacity(savedHabits.isEmpty ? 1 : 0.5)
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: "SavedHabits") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([MyHabit].self, from: data) {
                    savedHabits = decoded
                }
            }
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
    
    func saveHabitsToStorage(_ habits: [MyHabit]) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Ensure proper encoding of Date objects
        if let encoded = try? encoder.encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "SavedHabits")
        }
    }
}

struct CreateHabit_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabit()
    }
}
