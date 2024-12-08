import Foundation
import SwiftUI


struct FoodDetail: View {
    var food: Food
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(String(format: "%d%@", food.servingSize, food.servingSizeUnit.rawValue))
                Text(food.name)
            }.font(.body).bold()
            HStack {
                if let cal = food.calories {
                    Text(String(format: "Calories: %dg", cal))
                }
                if let pro = food.protein {
                    Text(String(format: "Protein: %dg", pro))
                }
                if let fat = food.fat {
                    Text(String(format: "Fat: %dg", fat))
                }
                if let carbs = food.carbs {
                    Text(String(format: "Carbs: %dg", carbs))
                }
            }.font(.system(size: 15))
        }
    }
}
