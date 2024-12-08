import Foundation
import SwiftUI

struct FoodResponse: Decodable{
    var parsed: [FoodResponse2]
}

struct FoodResponse2: Decodable{
    var food: FoodResponse3
}

struct FoodResponse3: Decodable{
    var label: String
    var nutrients: Nutrients
}

struct Nutrients: Decodable{
    var ENERC_KCAL: Double
    var PROCNT: Double
    var FAT: Double
    var CHOCDF: Double
    var FIBTG: Double
}

struct Food: Identifiable {
    var id: UUID = UUID()
    var name: String
    var servingSize: Int
    var servingSizeUnit: ServingSizeUnit
    var calories: Int?
    var protein: Int?
    var fat: Int?
    var carbs: Int?
    
    
    enum ServingSizeUnit: String, CaseIterable, Identifiable {
        var id: Self { self }
        case g, oz, lb, cup, other
    }
    
    enum MacroNutrients: String {
        case calories, protein, fat, carbs
    }
    
    struct FormData {
        var name: String = ""
        var servingSize: String = ""
        var servingSizeUnit: ServingSizeUnit = ServingSizeUnit.g
        var calories: String = ""
        var protein: String = ""
        var fat: String = ""
        var carbs: String = ""
    }

    var dataForForm: FormData {
        get {FormData(
            name: name,
            servingSize: String(servingSize),
            servingSizeUnit: servingSizeUnit,
            calories: calories != nil ? String(calories!) : "",
            protein: protein != nil ? String(protein!) : "",
            fat: fat != nil ? String(fat!) : "",
            carbs: carbs != nil ? String(carbs!) : "")
        }
        set {}
    }

    static func create(from formData: FormData) -> Food {
        Food(
            name: formData.name,
            servingSize: formData.calories.filter{"0123456789".contains($0)}.isEmpty ? 0 : Int(formData.servingSize) ?? 0,
            servingSizeUnit: formData.servingSizeUnit,
            calories: formData.calories.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.calories),
            protein: formData.protein.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.protein),
            fat: formData.fat.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.fat),
            carbs: formData.carbs.filter{"0123456789".contains($0)}.isEmpty ? nil : Int(formData.carbs))
    }
}

extension Food {
    static let previewData: [Food] = [
        Food(name: "Orange", servingSize: 140, servingSizeUnit: ServingSizeUnit.g, calories: 73, protein: 1, fat: 0, carbs: 16),
        Food(name: "Steak", servingSize: 8, servingSizeUnit: ServingSizeUnit.oz, calories: 650, protein: 60, fat: 45, carbs: 0),
        Food(name: "Popcorn", servingSize: 3, servingSizeUnit: ServingSizeUnit.cup, calories: 93, protein: 3, fat: 1, carbs: 19),
        Food(name: "Blueberries", servingSize: 1, servingSizeUnit: ServingSizeUnit.cup, calories: 80, protein: 1, fat: 0, carbs: 21)
    ]
}
