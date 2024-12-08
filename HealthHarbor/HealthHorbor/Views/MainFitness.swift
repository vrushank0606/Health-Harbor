
import SwiftUI

struct MainFitness: View {
    let workout = Workout(name: "Set a workout name", exercises: [])
    var body: some View {
        ZStack{
            Rectangle().fill(Gradient(colors: [.white.opacity(0.6), .yellow.opacity(0.25)])).ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading){
                    Text("FITNESS")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        .padding(.leading, 10)
                    HStack{
                        NavigationLink(destination: CurrentWorkout(workout: Workout(name: "Set a workout name", exercises: []))){
                            Text("Begin New Workout")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue).shadow(radius: 3))
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .multilineTextAlignment(.center)
                        }
                        
                        Text("Begin a workout with no template")
                            .multilineTextAlignment(.leading)
                    }
                    
                    .padding(.bottom, 40)
                    
                    HStack{
                        NavigationLink(destination: WorkoutTemplates()){
                            Text("My Templates")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange).shadow(radius: 3))
                        }
                        .padding(.trailing, 10)
                        Text("View/edit templates or begin workout from a template")
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 5)
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, 40)
                    HStack{
                        NavigationLink(destination: WorkoutHistory()){
                            Text("Workout History")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green).shadow(radius: 3))
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                        }
                        Text("View your completed workouts")
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MainFitness_Previews: PreviewProvider {
    static var previews: some View {
        MainFitness()
    }
}
