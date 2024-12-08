
import SwiftUI

struct WorkoutTemplateForm: View {
    @Binding var data: WorkoutTemplate.FormData
    
    var body: some View {
        VStack{
            Form{
                
                TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Workout Template Name")
                
            }
        }
    }
}

struct WorkoutTemplateForm_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateForm(data: Binding.constant(WorkoutTemplate.previewData[0].dataForForm))
    }
}
