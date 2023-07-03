import SwiftUI

//struct Habit: Identifiable, Codable {
//    let id = UUID()
//    let name: String
//    let selectedDays: [String]
//}

struct SettingsView: View {
    @State private var name: String = "Enter your name here"
    @State private var habits: [Habit] = []
    @State private var alert: Alert?

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Profile")) {
                    HStack(alignment: .center) {
                        Spacer()
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 110))
                                .foregroundColor(.secondary)

                            TextField("Enter your name", text: $name)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Habit Resources")) {
                    NavigationLink(destination: HabitInformation()) {
                        Label("Habit Information", systemImage: "info.circle")
                    }

                    VStack {
                        ForEach(habits) { habit in
                            Text(habit.name)
                            Text(habit.selectedDays.joined(separator: ", "))
                        }
                        .onDelete(perform: deleteHabit)
                    }
                }

                Section(header: Text("Resources & Support")) {
                    NavigationLink(destination: CreateAccountView()) {
                        Label("Create Account", systemImage: "person.crop.circle")
                    }

                    NavigationLink(destination: ContactDeveloperView()) {
                        Label("Contact Developer", systemImage: "hammer")
                    }
                    NavigationLink(destination: HowToUseApp()) {
                        Label("How to Use 1Habit", systemImage: "questionmark")
                    }

                    Link(destination: URL(string: "https://github.com/jasjs1/1Habit/issues/new?assignees=&labels=bug&projects=&template=BugReport.md&title=%5BBUG+REPORT%5D+-+")!) {
                        HStack(spacing: 22) {
                            Image(systemName: "link")
                            Text("Bug Report")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/jasjs1/1Habit/issues/new?assignees=&labels=user-feedback&projects=&template=UserFeedback.md&title=%5BUSER+FEEDBACK%5D+-+")!) {
                        HStack(spacing: 22) {
                            Image(systemName: "link")
                            Text("Give App Feedback")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .onAppear(perform: retrieveHabitsFromStorage)
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

    private func deleteHabit(at indices: IndexSet) {
        habits.remove(atOffsets: indices)
        saveHabitsToStorage(habits)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
