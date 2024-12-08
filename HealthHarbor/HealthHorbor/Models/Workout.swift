
import Foundation


struct WorkoutTemplate: Identifiable{
    var id: UUID = UUID()
    var name: String
    var exercises: [ExerciseTemplate]
    
    struct FormData{
        var id: UUID = UUID()
        var name: String = ""
        var exercises: [ExerciseTemplate] = []
        
    }
    
    var dataForForm: FormData {
        FormData(
            name: name,
            exercises: exercises
        )
    }
    
    static func create(from formData: FormData) -> WorkoutTemplate {
        let workoutTemp = WorkoutTemplate(id: formData.id, name: formData.name, exercises: formData.exercises)
        return WorkoutTemplate.update(workoutTemp, from: formData)
    }
    
    static func update(_ workoutTemp: WorkoutTemplate, from formData: FormData) -> WorkoutTemplate {
        var workoutTemp = workoutTemp
        workoutTemp.name = formData.name
        return workoutTemp
    }
    
    //These two functions needed to add or delete exercises to a workout template that is not in the data store yet as we can't update something that isn't there
    mutating func deleteExerciseTemplate (_ exerciseTemp: ExerciseTemplate){
        if let index = self.exercises.firstIndex(where: {$0.id == exerciseTemp.id}){
            self.exercises.remove(at: index)
        }
    }
    
    mutating func addExerciseTemplate (_ exerciseTemp: ExerciseTemplate){
        self.exercises.append(exerciseTemp)
    }
    
    mutating func updateWorkoutTemplate(_ exerciseTemplate: ExerciseTemplate){
        if let index = exercises.firstIndex(where: {$0.id == exerciseTemplate.id}){
            exercises[index] = exerciseTemplate
        }
    }
}


struct ExerciseTemplate: Identifiable{
    var id: UUID = UUID()
    var name: String
    var muscle: String
    
    struct FormData {
        var id: UUID = UUID()
        var name: String = ""
        var muscle: String = ""
    }
    
    var dataForForm: FormData {
        FormData(
            id: id,
            name: name,
            muscle: muscle
        )
    }
    
    static func create(from formData: FormData) -> ExerciseTemplate {
        ExerciseTemplate(id: formData.id, name: formData.name, muscle: formData.muscle)
    }
    
    static func update(_ exerciseTemp: ExerciseTemplate, from formData: FormData) -> ExerciseTemplate {
        var exerciseTemp = exerciseTemp
        exerciseTemp.name = formData.name
        exerciseTemp.muscle = formData.muscle
        return exerciseTemp
    }
}


struct Workout: Identifiable{
    var id: UUID = UUID()
    var name: String
    var exercises: [Exercise]
    var startedAt: Date = Date.now
    
    static func reverseSort(_ workouts: [Workout]) -> [Workout]{
        return Array(workouts.sorted(by: {$0.startedAt > $1.startedAt}))
    }
    
    mutating func addExercise(_ exercise: Exercise){
        self.exercises.append(exercise)
    }
    
    mutating func deleteExercise(_ exercise: Exercise){
        if let index = self.exercises.firstIndex(where: {$0.id == exercise.id}){
            self.exercises.remove(at: index)
        }
    }
    
    mutating func updateWorkout(_ exercise: Exercise){
        if let index = exercises.firstIndex(where: {$0.id == exercise.id}){
            exercises[index] = exercise
        }
    }
    
    struct FormData{
        var name: String = ""
        
    }
    
    var dataForForm: FormData {
        FormData(
            name: name
        )
    }
    
    static func update(_ workout: Workout, from formData: FormData) -> Workout {
        var workout = workout
        workout.name = formData.name
        return workout
    }
    
    mutating func changeName(_ name: String){
        self.name = name
    }
}

extension Workout{
    static func startWorkoutFromTemplate(from template:WorkoutTemplate) -> Workout{
        let workout = Workout(name: template.name, exercises: template.exercises.map { Exercise.init(template: $0, activities: [])})
        return workout
    }
}
struct ExerciseResponse: Hashable, Decodable{
    let name: String
    let type: String?
    let muscle: String
    let equipment: String?
    let difficulty: String?
    let instructions: String?
}



struct Exercise: Identifiable{
    var id: UUID = UUID()
    var name: String
    var muscle: String
    var activities: [Activity] = []
    
    
    mutating func addActivity(){
        self.activities.append(Activity(weight: 0, reps: 0))
    }
    
    mutating func deleteActivity(_ activity: Activity){
        if let index = self.activities.firstIndex(where: {$0.id == activity.id}){
            self.activities.remove(at: index)
        }
    }
    
    struct FormData {
        var id: UUID = UUID()
        var name: String = ""
        var muscle: String = ""
        var activities: [Activity] = []
    }
    
    var dataForForm: FormData {
        FormData(
            id: id,
            name: name,
            muscle: muscle,
            activities: activities
        )
    }
    
    static func create(from formData: FormData) -> Exercise {
        Exercise(id: formData.id, name: formData.name, muscle: formData.muscle, activities: formData.activities)
    }
    
    static func update(_ exercise: Exercise, from formData: FormData) -> Exercise {
        var exercise = exercise
        exercise.name = formData.name
        exercise.muscle = formData.muscle
        return exercise
    }
}

extension Exercise {
    init(template: ExerciseTemplate, activities: [Activity]) {
        self.name = template.name
        self.muscle = template.muscle
        self.activities = activities
    }
}


struct Activity: Identifiable{
    var id: UUID = UUID()
    var weight: Int
    var reps: Int
    var completed: Bool = false
}



extension WorkoutTemplate{
    static let previewData = [
        WorkoutTemplate(name: "Push Day",
                        exercises: [ExerciseTemplate(name: "Bench Press", muscle: "Chest"),
                                    ExerciseTemplate(name: "Incline Press", muscle: "Chest"),
                                    ExerciseTemplate(name: "Skull Crushers", muscle: "Tricep")]),
        
        WorkoutTemplate(name: "Pull Day",
                        exercises: [ExerciseTemplate(name: "Cable Row", muscle: "Mid Back"),
                                    ExerciseTemplate(name: "Pull Ups", muscle: "Back"),
                                    ExerciseTemplate(name: "Bicep Curls", muscle: "Bicep")]),
        
        WorkoutTemplate(name: "Leg Day",
                        exercises: [ExerciseTemplate(name: "Squat", muscle: "Quads"),
                                    ExerciseTemplate(name: "Leg Curl", muscle: "Hamstrings"),
                                    ExerciseTemplate(name: "Leg Extensions", muscle: "Quads")])]
    
}

extension Workout{
    static let previewData = [
        
        Workout(name: "Double Chest Workout",
                exercises: [
                Exercise(name: "Bench Press", muscle: "Chest", activities: [Activity(weight: 100, reps: 10), Activity(weight: 100, reps: 10), Activity(weight: 135, reps: 8)]),
                Exercise(name: "Incline Press", muscle: "Chest", activities: [Activity(weight: 80, reps: 10), Activity(weight: 80, reps: 8), Activity(weight: 100, reps: 6)])],
               startedAt: Date(timeIntervalSinceReferenceDate:  724402295.58)),
        
        
        Workout(name: "Quad Focused Leg Day",
                exercises: [
                Exercise(name: "Squats", muscle: "Quads/Glutes", activities: [Activity(weight: 135, reps: 10), Activity(weight: 185, reps: 10), Activity(weight: 185, reps: 10)]),
                Exercise(name: "Leg Curls", muscle: "Hamstrings", activities: [Activity(weight: 100, reps: 10), Activity(weight: 110, reps: 10), Activity(weight: 120, reps: 8)]),
                Exercise(name: "Leg Extensions", muscle: "Quads", activities: [Activity(weight: 120, reps: 10), Activity(weight: 130, reps: 8), Activity(weight: 150, reps: 5)])],
                startedAt: Date(timeIntervalSinceReferenceDate: 724402295.58)),
        
        
        Workout(name: "Bicep Day",
                exercises: [
                Exercise(name: "Bicep Curls", muscle: "Bicep", activities: [Activity(weight: 25, reps: 10), Activity(weight: 30, reps: 10)]),
                Exercise(name: "Preacher Curls", muscle: "Bicep", activities: [Activity(weight: 60, reps: 10), Activity(weight: 60, reps: 10), Activity(weight: 70, reps: 8)])],
                startedAt: Date(timeIntervalSinceReferenceDate: 724402295.58)),
        
        
        Workout(name: "Two Chest, One Tricep Workout",
                exercises: [
                Exercise(name: "Bench Press", muscle: "Chest", activities: [Activity(weight: 135, reps: 10), Activity(weight: 135, reps: 10), Activity(weight: 155, reps: 9)]),
                Exercise(name: "Incline Press", muscle: "Chest", activities: [Activity(weight: 80, reps: 10), Activity(weight: 80, reps: 10), Activity(weight: 100, reps: 8)]),
                Exercise(name: "Tricep Cable Extension", muscle: "Tricep", activities: [Activity(weight: 30, reps: 12), Activity(weight: 35, reps: 12), Activity(weight: 40, reps: 10)])],
               startedAt: Date(timeIntervalSinceReferenceDate: 724402295.58))
    ]
}
