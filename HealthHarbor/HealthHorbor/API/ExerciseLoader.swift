

import Foundation

class ExerciseLoader: ObservableObject {
    let apiClient: ExerciseAPIService
    
    @Published private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: [ExerciseResponse])
        case failed(error: Error)
    }
    
    init(apiClient: ExerciseAPIService) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadExercisesByName(name: String) async {
        self.state = .loading
        do {
            let exercises = try await apiClient.fetchExercisesByName(search: name)
            self.state = .success(data: exercises)
        } catch {
            self.state = .failed(error: error)
        }
    }
    @MainActor
    func loadExercisesByMuscle(muscle: String) async {
        self.state = .loading
        do {
            let exercises = try await apiClient.fetchExercisesByMuscle(search: muscle)
            self.state = .success(data: exercises)
        } catch {
            self.state = .failed(error: error)
        }
    }
}
