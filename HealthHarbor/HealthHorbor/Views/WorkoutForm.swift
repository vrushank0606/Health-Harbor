
import SwiftUI

struct WorkoutForm: View {
    @Binding var data: Workout.FormData
    
    var body: some View {
        VStack{
            Form{
                
                TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Workout Name")
                
            }
        }
    }
}

struct WorkoutForm_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutForm(data: Binding.constant(Workout.previewData[0].dataForForm))
    }
}
