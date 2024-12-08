
import SwiftUI

struct BMR_Calculator: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Your height in inches is \(user.height)")
                .padding()
            Text("Your weight in pounds is \(user.weight)")
                .padding()
            Text("Your age is \(user.age)")
                .padding()
            Text("Your Base Metabolic Rate, or calories your body will burn in one day to sustain itself is \(user.BMR)")
                .padding()
        }
    }
}

struct BMR_Calculator_Previews: PreviewProvider {
    static var previews: some View {
        BMR_Calculator(user: User.previewData[0])
    }
}
