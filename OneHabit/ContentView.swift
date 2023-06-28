import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var selectedDays: [String]
}

struct ContentView: View {
    @State private var habits: [Habit] = []
    
    var remainingDays: Int {
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year, .month], from: Date())
        
        guard let lastDayOfMonth = calendar.date(from: DateComponents(year: currentComponents.year, month: currentComponents.month?.advanced(by: 1) ?? 1))?.addingTimeInterval(-1) else {
            return 0
        }
        
        let remainingDays = calendar.dateComponents([.day], from: Date(), to: lastDayOfMonth)
        return remainingDays.day ?? 0
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    CalendarView()
                        .padding()
                    
                    Text("Remaining days of the month: \(remainingDays) days")
                        .font(.headline)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    Button(action: logHabitCompletedForToday) {
                        Text("Mark Day as Completed")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.yellow)
                            .font(.title3)
                            .bold()
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
            }
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
    
    func logHabitCompletedForToday() {
        let currentDate = Date()
        let userDefaults = UserDefaults.standard
        
        // Check if the streak has already been incremented today
        if let lastIncrementDate = userDefaults.object(forKey: "LastStreakIncrementDate") as? Date {
            if Calendar.current.isDateInToday(lastIncrementDate) {
                // Streak already incremented today, show alert
                // You can customize the alert message as per your requirement
                showAlert(message: "You've already logged your Habit Streak for today. Please remember to come back tomorrow to continue tracking your progress.")
                return
            }
        }
        
        // Increment the streak
        if var streak = userDefaults.value(forKey: "Streak") as? Int {
            streak += 1
            userDefaults.set(streak, forKey: "Streak")
        } else {
            // No previous streak found, set initial streak to 1
            userDefaults.set(1, forKey: "Streak")
        }
        
        // Save the current date as the last streak increment date
        userDefaults.set(currentDate, forKey: "LastStreakIncrementDate")
        
        // Show a success message or perform any other actions you want
    }

    func showAlert(message: String) {
        // Show an alert with the provided message
        // You can customize the alert appearance and actions as per your requirement
        let alert = UIAlertController(title: "Habit Streak Notification", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

struct CalendarView: View {
    let calendar = Calendar.current
    let currentDate = Date()
    
    var body: some View {
        VStack {
            Text(currentDate.monthAsString())
                .font(.title)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                ForEach(1...lastDayOfMonth(), id: \.self) { day in
                    Text("\(day)")
                        .frame(width: 30, height: 30)
                        .background(day == calendar.component(.day, from: currentDate) ? Color.yellow : Color.clear)
                        .cornerRadius(15)




                }
            }
        }
    }
    
    func lastDayOfMonth() -> Int {
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        return range.count
    }
}

extension Date {
    func monthAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
