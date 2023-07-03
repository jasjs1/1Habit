import SwiftUI

//struct Habit: Identifiable, Codable {
//    var id = UUID()
//    var name: String
//    var selectedDays: [String]
//}

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
                            deleteHabit(habit)
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
    
    private func deleteHabit(_ habit: Habit) {
        struct Habit: Identifiable, Codable {
            var id = UUID()
            var name: String
            var selectedDays: [String]
    
        }


        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].selectedDays = [] // Resetting selected days
            habits[index].name = ""
//            habits[index].streak = 0 // Resetting streak
            saveHabitsToStorage(habits)
        }
    }
    

    
    struct HabitInformation_Previews: PreviewProvider {
        static var previews: some View {
            HabitInformation()
        }
    }
}
