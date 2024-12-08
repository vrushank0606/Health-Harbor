
import Foundation

protocol FoodAPI {
    func fetchFood(search: String) async throws -> FoodResponse
}

struct FoodAPIService: FoodAPI, APIClient {
    func fetchFood(search: String) async throws -> FoodResponse {
        let path = FoodAPIEndpoint.path(search: search)
        let response: FoodResponse = try await performRequest(url: path, isExercise: false)
        return response
    }


    let session: URLSession = .shared
}
