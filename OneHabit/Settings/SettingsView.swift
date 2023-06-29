import SwiftUI

//struct Habit: Identifiable, Codable {
//    var id = UUID()
//    var name: String
//    var selectedDays: [String]
//}

struct SettingsView: View {
    @State private var name: String = "Enter your name here"
    
    var body: some View {
        NavigationView {
            List {
                HStack(alignment: .center) {
                    Spacer()
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 110))
                            .foregroundColor(.secondary)
                        
                        TextField("Enter your name", text: $name)
                            .multilineTextAlignment(.center) // Center align the TextField text
                            .frame(maxWidth: .infinity) // Ensure TextField occupies entire available width
                    }
                    Spacer()
                }
                
                Section(header: Text("Habit resources")) {
                    NavigationLink(destination: HabitInformation()) {
                        Text("Habit Information")
                    }
                    
                    
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
            }
            
                Section(header: Text("Support & resources")) {
                    NavigationLink(destination: CreateAccountView()) {
                        Text("Create Account")
                    }
                    
                    NavigationLink(destination: ContactDeveloperView()) {
                        Text("Contact Developer")
                    }
            }
        }
    }
    
    
    private func deleteHabit(_ habit: Habit) {
        struct Habit: Identifiable, Codable {
            var id = UUID()
            var name: String
            var selectedDays: [String]
            
        }
        
        
        struct SettingsView_Previews: PreviewProvider {
            static var previews: some View {
                SettingsView()
            }
        }
    }
}
