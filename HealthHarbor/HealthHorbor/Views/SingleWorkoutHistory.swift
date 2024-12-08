
import SwiftUI

struct SingleWorkoutHistory: View {
    let workout: Workout
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text(workout.name)
                    .padding(.bottom, 10)
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack{
                    Text("Date:")
                        .fontWeight(.semibold)
                    Text("\(workout.startedAt.formatted(date: .abbreviated, time: .shortened))")
                    
                }
                .padding(.bottom, 25)
                ForEach(workout.exercises){exercise in
                    VStack(alignment: .leading){
                        HStack{
                            Text(exercise.name)
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(.bottom, 0.5)
                            Text("(\(exercise.muscle))")
                                .font(.title3)
                        }
                        
                        HStack{
                            Text("Set:")
                            Text("Weight:")
                                .padding(.leading, 61)
                            Text("Reps:")
                                .padding(.leading, 58)
                        }
                        .padding(.bottom, 1)
                        
                        ForEach(exercise.activities){activity in
                            HStack{
                                Text("\(exercise.activities.firstIndex(where: {$0.id == activity.id})! + 1)")
                                    .padding(5)
                                    .frame(width: 30)
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1.1))
                                    .multilineTextAlignment(.center)
                                
                                Text("\(activity.weight)")
                                    .padding(5)
                                    .frame(width: 60)
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1.1))
                                    .padding(.leading, 60)
                                Text("\(activity.reps)")
                                    .padding(5)
                                    .frame(width: 40)
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1.1))
                                    .padding(.leading, 60)
                            }
                        }
                    }
                    .padding(.bottom)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.15)))
            .padding()
            
        }
    }
}

struct SingleWorkoutHistory_Previews: PreviewProvider {
    static var previews: some View {
        SingleWorkoutHistory(workout: Workout.previewData[0])
    }
}
