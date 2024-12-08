import Foundation
import SwiftUI


struct MyTDECalculator: View {
    let user: User
    let foods: [Food] // Assuming this is passed to the view

    var totalCaloriesConsumed: Int {
        CalculateMacroNutrients(foods: foods, nutrient: .calories)
    }


    var body: some View {
        HStack(alignment: .center) {
           
            TDEBox(
                headline: "BMR",
                result: String(format: "%.2f", user.BMR))
            Text("+").font(.title3).bold()
            TDEBox(
                headline: "Active Cal",
                result: String( totalCaloriesConsumed))
            Text("=").font(.title3).bold()
            
            let bmr = Int(user.BMR)
            let res = bmr + totalCaloriesConsumed
            
            TDEBox(
                headline: "TDE",
                result: String( res))
           
        }
    }
    
    struct TDEBox: View {
        let headline: String
        let result: String
        
        var body: some View {
            VStack(alignment: .center) {
                Text(headline).font(.title3).bold()
                Text(result)
            }.padding(8).border(.black)
        }
    }
}
