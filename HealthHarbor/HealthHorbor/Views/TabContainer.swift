
import Foundation
import SwiftUI

struct TabContainer: View {
    @EnvironmentObject var dataStore: DataStore
  
    var body: some View {
        TabView{
            NavigationStack {
                UserInfo()
            }
            .tabItem { Label("User Info", systemImage: "person.circle") }
            NavigationStack {
                MainFitness()
            }
            .tabItem { Label("Fitness", systemImage: "figure.run") }
            NavigationStack {
                NutritionPage(user: Binding.constant(dataStore.userList[0]))
            }
            .tabItem { Label("Nutrition", systemImage: "fork.knife") }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
  static var previews: some View {
      TabContainer().environmentObject(DataStore())
  }
}
