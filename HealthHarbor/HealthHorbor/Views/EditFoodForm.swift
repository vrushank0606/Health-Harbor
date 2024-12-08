import Foundation
import SwiftUI

struct EditFoodForm: View {
    @EnvironmentObject var dataStore: DataStore
    let food: Food
    let originalServingSize: Int?
    
    
    var body: some View {
        Text("Edit Food")
        Text(food.name)
    }
}

struct EditFoodForm_Previews: PreviewProvider {
    static var previews: some View {
        EditFoodForm(
            food: Food.previewData[0],
            originalServingSize: Food.previewData[0].servingSize
        ).environmentObject(DataStore())
    }
}
