
import SwiftUI

struct WorkoutHistory: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ScrollView{
            Text("Workout History")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            ForEach(Workout.reverseSort(dataStore.workouts)) { workout in
                NavigationLink(destination: SingleWorkoutHistory(workout: workout)){
                    VStack(alignment: .leading){
                        Text(workout.name)
                            .padding(.bottom, 10)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        HStack{
                            Text(workout.startedAt.formatted())
                                .foregroundColor(.black)
                                .font(.title3)
                                .padding(.bottom, 5)
                            Spacer()
                            VStack(alignment: .trailing){
                                Image(systemName: "arrow.forward")
                                Text("Full Details")
                            }
                                
                        }
                        ForEach(workout.exercises){exercise in
                            Text(exercise.name)
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.15)))
                    .padding()
                }
            }
        }
    }
}

struct WorkoutHistory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WorkoutHistory()
                .environmentObject(DataStore())
        }
    }
}
