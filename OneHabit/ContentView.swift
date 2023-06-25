import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var selectedDays: [String]
    var streakCount: Int
    var notificationTime: Date?
}

struct ContentView: View {
    @State private var habits: [Habit] = []
    @State private var isAddingHabit = false
    @State private var newHabitName = ""
    @State private var newHabitDays = [String]()
    @State private var newHabitReminderTime = Date()

    var body: some View {
        NavigationView {
            List {
                ForEach(habits) { habit in
                    Text(habit.name)
                }
                .onDelete(perform: deleteHabit)
            }
            .navigationBarTitle("1Habit")
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $isAddingHabit) {
                createHabitView()
            }
        }
    }

    private var addButton: some View {
        Button(action: {
            isAddingHabit = true
        }) {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "plus")
                    .font(.title)
                    .bold()
                    .foregroundColor(.accentColor)
                Rectangle()
                    .frame(width: 40, height: 40)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .cornerRadius(12)
            }
        }
    }

    private func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        saveHabits()
    }

    private func saveHabits() {
        do {
            let data = try JSONEncoder().encode(habits)
            UserDefaults.standard.set(data, forKey: "habits")
        } catch {
            print("Error saving habits: \(error)")
        }
    }

    private func loadHabits() {
        if let data = UserDefaults.standard.data(forKey: "habits") {
            do {
                habits = try JSONDecoder().decode([Habit].self, from: data)
            } catch {
                print("Error loading habits: \(error)")
            }
        }
    }

    private func createHabitView() -> some View {
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
            
            DatePicker("Habit Reminder time", selection: $newHabitReminderTime, in: ...Date())


        }
        .padding()
        .navigationBarTitle("New Habit")
        .onAppear {
            newHabitDays = []
            newHabitReminderTime = Date()
        }
    }

    private func bindingForDay(_ day: String) -> Binding<Bool> {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
