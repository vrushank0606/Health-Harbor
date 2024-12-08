
import SwiftUI

struct UserForm: View {
    @Binding var data: User.FormData
    @State private var formatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.usesSignificantDigits = true
        return nf
    }()
    
    var body: some View {
        Form{
            
            TextFieldWithLabelDouble(label: "Age", double: $data.age)
            TextFieldWithLabelDouble(label: "Height (inches)", double: $data.height)
            TextFieldWithLabelDouble(label: "Weight (pounds)", double: $data.weight)
            Picker(selection: $data.sex, label: Text("Sex").font(.title3).bold()) {
                ForEach(User.Sex.allCases){
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.menu)
            
        }
        
    }
}

struct TextFieldWithLabelDouble: View {
    let label: String
    @Binding var double: Double
    var prompt: String? = nil
    let numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.usesSignificantDigits = true
        return nf
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label) :")
                .bold()
                .font(.title3)
                .padding(.bottom, 1)
            TextField(label, value: $double, formatter: numberFormatter, prompt: prompt != nil ? Text(prompt!) : nil)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 3))
                .keyboardType(.default)
        }
        .padding(.bottom, 20)
        .padding(.trailing, 2)
    }
}

struct UserForm_Previews: PreviewProvider {
    static var previews: some View {
        UserForm(data: Binding.constant(User.previewData[0].dataForForm))
    }
}
