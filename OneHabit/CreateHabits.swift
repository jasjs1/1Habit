import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var selectedDays: [String]
}

struct ContentView: View {
    @State private var habits: [Habit] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits) { habit in
                    Section(header: Text("your habits")) {
                        ForEach(habit.selectedDays, id: \.self) { day in
                            Text(habit.name)
                            Text(day)
                        }
                    }
                }
                .onDelete { indices in
                    habits.remove(atOffsets: indices)
                    saveHabitsToStorage(habits)
                }
            }
            .navigationBarTitle("1Habit")
            .navigationBarItems(trailing: EditButton())
            .onAppear {
                retrieveHabitsFromStorage()
            }
        }
    }
    
    func retrieveHabitsFromStorage() {
        if let data = UserDefaults.standard.data(forKey: "SavedHabits") {
            let decoder = JSONDecoder()
            if let decodedHabits = try? decoder.decode([Habit].self, from: data) {
                habits = decodedHabits
            }
        }
    }
    
    func saveHabitsToStorage(_ habits: [Habit]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "SavedHabits")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
