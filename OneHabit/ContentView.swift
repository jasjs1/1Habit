import SwiftUI

struct Habit: Identifiable {
    var id = UUID()
    var name: String
}

struct ContentView: View {
    @State private var habits: [Habit] = []
    @State private var isAddingHabit = false
    
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
    
    private func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    private var addButton: some View {
        Button(action: {
            isAddingHabit = true
        }) {
            Spacer()
           
        }
    }
    
    private func createHabitView() -> some View {
        Text("Create Habit View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
