
import SwiftUI

struct ExerciseTemplateForm: View {
    @Binding var data: ExerciseTemplate.FormData
    
    var body: some View {
        
        ScrollView{
            TextFieldWithLabel(label: "Name", text: $data.name, prompt: "Enter the name")
                .keyboardType(.default)
                .padding(.leading)
            
            TextFieldWithLabel(label: "Muscle", text: $data.muscle, prompt: "Enter a muscle")
                .keyboardType(.default)
                .padding(.leading)
        }
        
    }
}
    
    struct TextFieldWithLabel: View {
        let label: String
        @Binding var text: String
        var prompt: String? = nil
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("\(label) :")
                    .bold()
                    .font(.title3)
                    .padding(.bottom, 1)
                TextField(label, text: $text, prompt: prompt != nil ? Text(prompt!) : nil)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 3))
                    .keyboardType(.default)
            }
            .padding(.bottom, 40)
            .padding(.trailing, 2)
        }
    }
    
    struct ExerciseTemplateForm_Previews: PreviewProvider {
        static var previews: some View {
            ExerciseTemplateForm(data: Binding.constant(WorkoutTemplate.previewData[0].exercises[0].dataForForm))
        }
    }
