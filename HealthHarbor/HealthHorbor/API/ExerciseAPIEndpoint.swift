

import Foundation

struct ExerciseAPIEndpoint {
    static let baseUrl = "https://api.api-ninjas.com/v1/exercises"
    
    static func path(isName: Bool, search: String) -> String {
        let type: String = isName ? "?name=" : "?muscle="
        let url = "\(baseUrl)\(type)\(search)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "idk"
        print(url)
        return url
    }
}
