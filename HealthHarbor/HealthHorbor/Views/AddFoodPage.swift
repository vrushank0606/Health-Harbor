import Foundation
import SwiftUI

struct AddFoodPage: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var data: Food.FormData
    @State var creatingNewFood: Bool = false
    @State var searchTerm: String = ""
    @StateObject var foodLoader: FoodLoader = FoodLoader(apiClient: FoodAPIService())
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 40)
            Text("Add Food").font(.title).bold().padding()
            HStack {
                Button("Search My Food") {
                    creatingNewFood = false
                }.buttonStyle(.bordered).tint(creatingNewFood ? .gray : .blue)
                Button("Add New Food") {
                    creatingNewFood = true
                }.buttonStyle(.bordered).tint(creatingNewFood ? .blue : .gray)
            }.padding(.bottom, 20)
            if (creatingNewFood) {
                FoodEditorForm(data: $data)
            } else {
                SearchFoodForm(searchTerm: $searchTerm).environmentObject(foodLoader)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.9)
    }
}

struct AddFoodPage_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodPage(data: Binding.constant(Food.FormData())).environmentObject(DataStore())
    }
}
