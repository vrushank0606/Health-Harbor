import Foundation

struct User: Identifiable{
    var id: Int
    var age: Double
    var height: Double
    var weight: Double
    var sex: Sex
    
    var BMR:Double {
        if sex.rawValue == "male"{
            return 66.47+(6.24*weight)+(12.7*height)-(6.755*age)
        }
        else{
            return 655.1+(4.35*weight)+(4.7*height)-(4.7*age)
        }
    }
}
    
extension User{
    enum Sex: String, CaseIterable, Identifiable{
        var id: Self {self}
        case male
        case female
    }
}

extension User{
    struct FormData{
        var age: Double = 0.0
        var height: Double = 0.0
        var weight: Double = 0.0
        var sex: Sex = .male
    }
    
    var dataForForm: FormData {
        FormData(
            age: age,
            height: height,
            weight: weight,
            sex: sex
        )
    }
    
    static func update(_ user: User, from formData: FormData) -> User {
        var user = user
        user.age = formData.age
        user.height = formData.height
        user.weight = formData.weight
        user.sex = formData.sex
        return user
    }
}


extension User{
    static let previewData = [
        User(id: 1, age: 23, height: 71, weight: 168, sex: .male),
        User(id: 2, age: 21, height: 64, weight: 130, sex: .female)]
    
}
