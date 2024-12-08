import SwiftUI

struct WorkoutTemplates: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    @State var presentingWorkoutTemplate: Bool = false
    
    @State var newWorkoutTemplateFormData = WorkoutTemplate.FormData()
    
    let newTemp = WorkoutTemplate(name: "New Template", exercises: [ExerciseTemplate(name: "First Exercise", muscle: "Muscle")])
    
    
    var body: some View {
        ScrollView{
            Text("My Templates")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            ForEach(dataStore.templates.sorted(by: {$0.name<$1.name})) { template in
                SingleTemplate(template: template)
                
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink(destination: NewWorkoutTemplate(template: newTemp)){
                    Text("New Template +")
                }
            }
        }
    }
}

struct WorkoutTemplates_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WorkoutTemplates()
                .environmentObject(DataStore())
        }
    }
}
