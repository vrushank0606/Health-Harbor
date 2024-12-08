
import SwiftUI

struct TemplateDetails: View {
    let template: WorkoutTemplate
    
    @EnvironmentObject var dataStore: DataStore
    
    @Environment(\.dismiss) private var dismiss
    
    @State var newExerciseTemplateFormData = ExerciseTemplate.FormData()
    
    @State var presentingExerciseTemplate: Bool = false
    
    @State var presentingWorkoutTemplate: Bool = false
    
    @State var editWorkoutTemplateFormData = WorkoutTemplate.FormData()
    
    @State private var deleteConfirm = false
    
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
                
            
            ForEach(template.exercises){exercise in
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
                    dataStore.deleteExerciseTemplate(template, exercise)
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
            
            NavigationLink(destination: CurrentWorkout(workout: Workout.startWorkoutFromTemplate(from: template))){
                Text("Begin workout with this template")
                    .foregroundColor(.white)
                    .frame(width: 170, height: 50)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue).shadow(radius: 3))
                    .padding(.bottom, 50)
                    .multilineTextAlignment(.center)
            }
            
            
            
            Button("Delete Template"){
                deleteConfirm = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
            Spacer()
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
                                dataStore.addExerciseTemplate(template, newExerciseTemplate)
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
                                    dataStore.updateExerciseTemplate(template, editedExercise)
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
                        ToolbarItem(placement: .navigationBarTrailing){Button ("Save"){
                            let editedWorkoutTemplate = WorkoutTemplate.update(template, from: editWorkoutTemplateFormData)
                            dataStore.updateWorkoutTemplate(editedWorkoutTemplate)
                            presentingWorkoutTemplate.toggle()
                        }
                            
                        }
                    }
                    .toolbarBackground(.visible)
                    .toolbarColorScheme(.dark)
            }
        }
        .confirmationDialog("Do you want to delete this template?", isPresented: $deleteConfirm, titleVisibility: .visible){
            Button("Delete", role: .destructive){
                dataStore.deleteTemplate(template)
                dismiss()
            }
        }
    }
}

struct TemplateDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TemplateDetails(template: WorkoutTemplate.previewData[0])
                .environmentObject(DataStore())
        }
    }
}
