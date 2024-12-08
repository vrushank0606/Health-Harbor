
import SwiftUI

struct NewWorkoutTemplate: View {
    
    @State var template: WorkoutTemplate
    
    @EnvironmentObject var dataStore: DataStore
    
    @Environment(\.dismiss) private var dismiss
    
    @State var newExerciseTemplateFormData = ExerciseTemplate.FormData()
    
    @State var presentingExerciseTemplate: Bool = false
    
    @State var presentingWorkoutTemplate: Bool = false
    
    @State var editWorkoutTemplateFormData = WorkoutTemplate.FormData()
    
    @State var presentingExerciseTemplateEdit: Bool = false
    
    @State var editExerciseTemplateFormData = ExerciseTemplate.FormData()
    
    @State var editingExerciseTemplate: ExerciseTemplate?
    
    
    var body: some View {
        ScrollView{
            
            Text(template.name)
                .font(.title)
                .bold()
                .padding(.top, 40)
            
            Button("Edit name"){
                editWorkoutTemplateFormData = template.dataForForm
                presentingWorkoutTemplate.toggle()
            }
            .padding(.bottom, 20)
            
            
            ForEach($template.exercises){$exercise in
                Text("\(exercise.name)  (\(exercise.muscle))")
                    .font(.title3)
                    .padding(.top)
                    .padding(.bottom, 1)
                    .fontWeight(.semibold)
                
                Button("Edit Exercise"){
                    presentingExerciseTemplateEdit.toggle()
                    editingExerciseTemplate = exercise
                    editExerciseTemplateFormData = exercise.dataForForm
                }
                .padding(.bottom, 1)
                
                Button("Delete Exercise"){
                    template.deleteExerciseTemplate(exercise)
                }
                .tint(.red)
                
                .padding(.bottom)
            }
            Button("Add Exercise"){
                presentingExerciseTemplate.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.bottom, 50)
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Save Template"){
                    dataStore.addWorkoutTemplate(template)
                    dismiss()
                }
            }
        }
        .sheet(isPresented: $presentingExerciseTemplate){
            NavigationStack{
                AddExerciseTemplate(data: $newExerciseTemplateFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                presentingExerciseTemplate = false
                                newExerciseTemplateFormData = ExerciseTemplate.FormData()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button("Save"){
                                let newExerciseTemplate = ExerciseTemplate.create(from: newExerciseTemplateFormData)
                                template.addExerciseTemplate(newExerciseTemplate)
                                presentingExerciseTemplate = false
                                newExerciseTemplateFormData = ExerciseTemplate.FormData()
                            }
                        }
                    }
                    .toolbarBackground(.visible)
                    .toolbarColorScheme(.dark)
            }
        }
        .sheet(isPresented: $presentingExerciseTemplateEdit){
            NavigationStack{
                EditExerciseTemplate(data: $editExerciseTemplateFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                presentingExerciseTemplateEdit = false
                            }
                        }
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button("Save"){
                                if let editingExerciseTemplate = editingExerciseTemplate{
                                    let editedExercise = ExerciseTemplate.update(editingExerciseTemplate, from: editExerciseTemplateFormData)
                                    template.updateWorkoutTemplate(editedExercise)
                                    presentingExerciseTemplateEdit.toggle()
                                }
                            }
                        }
                    }
                    .toolbarBackground(.visible)
                    .toolbarColorScheme(.dark)
            }
        }
        
        .sheet(isPresented: $presentingWorkoutTemplate){
            NavigationStack{
                WorkoutTemplateForm(data: $editWorkoutTemplateFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                editWorkoutTemplateFormData = template.dataForForm
                                presentingWorkoutTemplate = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button ("Save"){
                                let editedWorkoutTemplate = WorkoutTemplate.update(template, from: editWorkoutTemplateFormData)
                                template = editedWorkoutTemplate
                                presentingWorkoutTemplate.toggle()
                            }
                            
                        }
                    }
                    .toolbarBackground(.visible)
                    .toolbarColorScheme(.dark)
            }
        }
    }
}

struct NewWorkoutTemplate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NewWorkoutTemplate(template: WorkoutTemplate(name: "Fake Template", exercises: [ExerciseTemplate(name: "Fake Exercise", muscle: "Fake Muscle")]))
        }
    }
}
