import Foundation
import SwiftUI

struct MyCaloricIntake: View {
    let foods: [Food]
    
    var body: some View {
        VStack {
            HStack {
                Text("Calories:").frame(maxWidth: .infinity, alignment: .leading)
                Text(String(CalculateMacroNutrients(
                    foods: foods, nutrient: Food.MacroNutrients.calories)))
            }.font(.title2).bold()
            HStack {
                Text("Protein:").frame(maxWidth: .infinity, alignment: .leading)
                Text(String(CalculateMacroNutrients(
                    foods: foods, nutrient: Food.MacroNutrients.protein)))
            }.font(.title2).bold()
            HStack {
                Text("Fat:").frame(maxWidth: .infinity, alignment: .leading)
                Text(String(CalculateMacroNutrients(
                    foods: foods, nutrient: Food.MacroNutrients.fat)))
            }.font(.title2).bold()
            HStack {
                Text("Carbs:").frame(maxWidth: .infinity, alignment: .leading)
                Text(String(CalculateMacroNutrients(
                    foods: foods, nutrient: Food.MacroNutrients.carbs)))
            }.font(.title2).bold()
        }
    }
}

func CalculateMacroNutrients(foods: [Food], nutrient: Food.MacroNutrients) -> Int {
    var total: Int = 0
    for food in foods {
        switch nutrient {
        case .calories:
            if let cal = food.calories {
                total += cal
            }
        case .protein:
            if let pro = food.protein {
                total += pro
            }
        case .fat:
            if let fat = food.fat {
                total += fat
            }
        case .carbs:
            if let carbs = food.carbs {
                total += carbs
            }
        }
    }
    return total
}
