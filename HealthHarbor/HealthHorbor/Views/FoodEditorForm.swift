import Foundation
import SwiftUI

struct FoodEditorForm: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var data: Food.FormData
    @State var hasBeenAdded: Bool = false
    
    var body: some View {
        HStack {
            Text("Food Name").font(.headline)
            TextField("", text: $data.name).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
        }
        Spacer(minLength: 40)
        HStack {
            Group {
                Text("Serving Size").font(.headline)
                TextField("", text: $data.servingSize).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            }
            Group {
                Text("Unit").font(.headline)
                Picker(selection: $data.servingSizeUnit, label: Text("Unit")) {
                    ForEach(Food.ServingSizeUnit.allCases) {
                        unit in Text(unit.rawValue)
                    }
                }
            }
        }
        Spacer(minLength: 40)
        HStack {
            VStack(alignment: .center) {
                Text("Calories").font(.headline)
                TextField("", text: $data.calories).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            }
            VStack(alignment: .center) {
                Text("Protein").font(.headline)
                TextField("", text: $data.protein).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            }
            VStack(alignment: .center) {
                Text("Fat").font(.headline)
                TextField("", text: $data.fat).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            }
            VStack(alignment: .center) {
                Text("Carbs").font(.headline)
                TextField("", text: $data.carbs).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
            }
        }
        Spacer(minLength: 30)
        Button(hasBeenAdded ? "Added!" : "Add Food to Daily Log") {
            let newFood = Food.create(from: data)
            dataStore.updateFoodLog(food: newFood)
            if !dataStore.isExistingFoodTemplate(food: newFood) {
                dataStore.updateFoodTemplates(food: newFood)
            }
            hasBeenAdded = true
        }.buttonStyle(.borderedProminent)
    }
}
