import Foundation
import SwiftUI

struct FoodLog: Identifiable {
    var id: Int
    var foods: [Food] = []
    
    static func addToLog(log: FoodLog, food: Food) -> FoodLog{
        var newLog = log
        newLog.foods.append(food)
        return newLog
    }
    
}

extension FoodLog {
    static let previewData: FoodLog = FoodLog(id: 1,foods: [
        Food(name: "Apple", servingSize: 100, servingSizeUnit: Food.ServingSizeUnit.g, calories: 52, protein: 1, fat: 0, carbs: 14),
        Food(name: "Banana", servingSize: 100, servingSizeUnit: Food.ServingSizeUnit.g, calories: 89, protein: 1, fat: 0, carbs: 23)])
}
