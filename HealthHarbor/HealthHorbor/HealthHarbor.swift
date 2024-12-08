import SwiftUI

@main
struct Fitness_Nutriton_App: App {
    @StateObject var dataStore = DataStore()
    
    var body: some Scene {
        WindowGroup {
            TabContainer().environmentObject(dataStore)
        }
    }
}
