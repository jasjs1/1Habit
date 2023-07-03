import SwiftUI
import Firebase
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    var timer: Timer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() // Initialize Firebase
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
        
        
        return true
    }
    
    func sendNotification(notificationTime: Date) {
        let content = UNMutableNotificationContent()
        
        // Get the habit name from device storage (replace "habitNameKey" with the actual key used to store the habit name)
        if let habitName = UserDefaults.standard.string(forKey: "habitNameKey") {
            content.title = "1Habit Habit Reminder"
            content.body = "Don't forget to \(habitName)!" // Use the habit name in the notification body
        } else {
            content.title = "1Habit Habit Reminder"
            content.body = "!!ERROR!! GETTING HABIT NAME PLEASE OPEN THE APP TO SEE WHAT IT IS!"
        }
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            }
        }
    }
    
    
    @main
    struct OneHabitApp: App {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        var body: some Scene {
            WindowGroup {
                TabView {
                    ContentView()
                        .tabItem {
                            Label("Your Habits", systemImage: "calendar")
                        }
                    CreateHabit()
                        .tabItem {
                            Label("Create Habit", systemImage: "square.and.pencil")
                        }
                    StreakView()
                        .tabItem {
                            Label("Streak", systemImage: "flame.fill")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
            }
        }
    }
}
