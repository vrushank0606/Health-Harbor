import Foundation
import SwiftUI


struct MyFoodLog: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var foodLog: FoodLog
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Food Log").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(foodLog.foods) {
                    food in
                    HStack(alignment: .center) {
                        FoodDetail(food: food).padding(.top, 10).frame(maxWidth: .infinity, alignment: .leading)
                        Button {
                            dataStore.removeFromFoodLog(food)
                        } label: {Label("", systemImage: "trash.fill")}
                    }
                }
            }.frame(maxHeight: UIScreen.main.bounds.height * 0.4)
        }
    }
}

