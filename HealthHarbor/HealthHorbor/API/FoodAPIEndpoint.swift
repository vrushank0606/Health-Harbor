

import Foundation

struct FoodAPIEndpoint {
    static let baseUrl = "https://api.edamam.com/api/food-database/v2/parser?"
    
    static func path(search: String) -> String {
        let apiID = "f1e6ae11"
        let apikey = "021722a7606cd775b644522d2d1f8bce"
        let url = "\(baseUrl)app_id=\(apiID)&app_key=\(apikey)&ingr=\(search)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "idk"
        print(url)
        return url
    }
}
