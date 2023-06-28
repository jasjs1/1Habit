import SwiftUI


struct HabitInformation: View {
    @State private var habits: [Habit] = []
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(habits) { habit in
                    VStack {
                        Text(habit.name)
                            .bold()
                            .font(.system(size: 24))
                            .padding(.top, 32)
                        HStack {
                            ForEach(habit.selectedDays, id: \.self) { day in
                                Text(day)
                            }
                        }
                        Spacer()
                        Button(action: {
                            reset()
                        }) {
                            VStack {
                                Image(systemName: "trash")
                                Text("Remove Habit")
                            }
                            .padding(.all, 6)
                            .cornerRadius(12)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("Habit Information")
            .onAppear {
                retrieveHabitsFromStorage()
            }
        }
    }
    
    private func retrieveHabitsFromStorage() {
        if let data = UserDefaults.standard.data(forKey: "SavedHabits") {
            let decoder = JSONDecoder()
            if let decodedHabits = try? decoder.decode([Habit].self, from: data) {
                habits = decodedHabits
            }
        }
    }
    
    private func saveHabitsToStorage(_ habits: [Habit]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "SavedHabits")
        }
    }
    
    
    private func reset() -> Habit {
        return Habit(name: "", selectedDays: [])
    }
    
    struct HabitInformation_Previews: PreviewProvider {
        static var previews: some View {
            HabitInformation()
        }
    }
}
