
import Foundation

class FoodLoader: ObservableObject {
    let apiClient: FoodAPIService
    
    @Published private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: FoodResponse)
        case failed(error: Error)
    }
    
    init(apiClient: FoodAPIService) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadFood(food: String) async {
        self.state = .loading
        do {
            let foods = try await apiClient.fetchFood(search: food)
            self.state = .success(data: foods)
        } catch {
            self.state = .failed(error: error)
        }
    }
}
