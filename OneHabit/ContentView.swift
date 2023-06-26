import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
}

struct ContentView: View {
    @State private var habits: [Habit] = []
    
    var body: some View {
        List(habits) { habit in
            Text(habit.name)
        }
        .onAppear {
            retrieveHabitsFromStorage()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
