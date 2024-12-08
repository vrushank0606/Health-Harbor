

import SwiftUI

struct AddExerciseTemplate: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var data: ExerciseTemplate.FormData
    @State var apiExerciseTemplate: Bool = false
    
    @EnvironmentObject var exerciseLoader: ExerciseLoader
    @State var searchText = ""
    @State var muscleSelection = "Name"
    var apiSelection = ["Name", "Muscle"]
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 40)
            Text("Add Exercise").font(.title).bold().padding()
            HStack {
                Button("Create Exercise") {
                    apiExerciseTemplate = false
                }.buttonStyle(.bordered).tint(apiExerciseTemplate ? .gray : .blue)
                Button("Choose From List") {
                    apiExerciseTemplate = true
                }.buttonStyle(.bordered).tint(apiExerciseTemplate ? .blue : .gray)
            }.padding(.bottom, 20)
            if (apiExerciseTemplate) {
                ScrollView{
                    TextFieldWithLabel(label: "Search For Exercise", text: $searchText, prompt: "Search Name")
                        .padding(.leading)
                    
                    Picker("API Search", selection: $muscleSelection) {
                        ForEach(apiSelection, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    Button("Search") {
                        Task {
                            
                            if muscleSelection == "Name" {
                                await exerciseLoader.loadExercisesByName(name: searchText)
                            } else {
                                await exerciseLoader.loadExercisesByMuscle(muscle: searchText)
                            }
                            
                        }
                        
                    }
                    
                    
                    Text("API Results Here")
                        .padding()
                    switch exerciseLoader.state {
                    case .idle: Color.clear
                    case .loading: ProgressView()
                    case .failed(let error): Text(error.localizedDescription)
                    case .success(let apiResponse):
                        ForEach(apiResponse, id: \.self) { exercise in
                            HStack {
                                Text(exercise.name)
                                Text(" : ")
                                Text(exercise.muscle)
                            }
                        }
                    }
                    Text("Clicking 'add' will autofill exercise name and muscle with that api results info")
                        .padding()
                    

                }
            } else {
                ExerciseTemplateForm(data: $data)
                    .padding(.top, 50)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.9)    }
}

struct AddExerciseTemplate_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseTemplate(data: Binding.constant(ExerciseTemplate.FormData())).environmentObject(DataStore())
            .environmentObject(ExerciseLoader(apiClient: ExerciseAPIService()))
    }
}
