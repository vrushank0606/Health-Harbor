import Foundation
import SwiftUI

struct SearchFoodForm: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var searchTerm: String
    @State var displaySearch: Bool = false
    @EnvironmentObject var foodLoader: FoodLoader
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TextField("Search", text: $searchTerm).textFieldStyle(RoundedBorderTextFieldStyle()).frame(minHeight: 40)
                    Button("Search") {
                        Task {
                            if !searchTerm.isEmpty {
                                dataStore.filterFoodTemplates(searchTerm: searchTerm)
                                displaySearch = true
                                await foodLoader.loadFood(food: searchTerm)
                            }
                        }
                    }
                    Button("Clear") {
                        Task {
                            searchTerm = ""
                            dataStore.resetFilteredFoodTemplates()
                            displaySearch = false
                        }
                    }
                    Spacer(minLength: 30)
                }.frame(width: UIScreen.main.bounds.width * 0.9)
                
                Divider()
                MyFoodsSearchResults(foods: $dataStore.filteredFoods)

                if (displaySearch) {
                    Divider()
                    switch foodLoader.state {
                    case .idle: Color.clear
                    case .loading: ProgressView()
                    case .failed(let error): Text(error.localizedDescription)
                    case .success(let apiResponse):
                        SuggestionsFromAPI(apiResponse: apiResponse)
                    }
                }
            }
        }
    }
    struct MyFoodsSearchResults: View {
        @Binding var foods: [Food]
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("My Food Bank").font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
                if foods.isEmpty {
                    Text("No matching foods in food bank")
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    ForEach($foods) { $food in
                        NavigationLink(
                            destination: NewFoodFromExisting(
                                data: $food.dataForForm,
                                food: food,
                                originalServingSize: food.servingSize)) {
                                    FoodDetail(food: food)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 8)
                                }
                    }
                }
            }.frame(maxWidth: .infinity)
        }
    }
    struct SuggestionsFromAPI: View {
        var apiResponse: FoodResponse
        
        var body: some View {
            VStack {
                Text("Suggestions").font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
                HStack {
                    Text(apiResponse.parsed.first?.food.label ?? "Failure")
                    Text(":")
                    Text("Calories: "+String(apiResponse.parsed.first?.food.nutrients.ENERC_KCAL ?? 0.0)+"g")
                    Text("Protein: "+String(apiResponse.parsed.first?.food.nutrients.PROCNT ?? 0.0)+"g")
                    Text("Fat: "+String(apiResponse.parsed.first?.food.nutrients.FAT ?? 0.0)+"g")
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity)
        }
    }
}

struct SearchFoodForm_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodForm(searchTerm: Binding.constant("Orange")).environmentObject(DataStore()).environmentObject(FoodLoader(apiClient: FoodAPIService()))
    }
}
