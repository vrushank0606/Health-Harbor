

import SwiftUI

struct UserInfo: View {
    @State var presentInfo = false
    @State var editUserFormData = User.FormData()
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("User Info")
                .font(.title)
                .bold()
                .padding(.leading, 150)
                .padding(.top, 30)
            
            Box(headline: "Age:", result: "\(dataStore.userList[0].age)")
                .padding(.top, 30)
                .padding(.leading, 20)
            Box(headline: "Height:", result: "\(dataStore.userList[0].height)")
                .padding(.top, 30)
                .padding(.leading, 20)
            Box(headline: "Weight:", result: "\(dataStore.userList[0].weight)")
                .padding(.top, 30)
                .padding(.leading, 20)
            
            HStack{
                Text("Sex:")
                    .bold()
                    .font(.title2)
                Text((dataStore.userList[0].sex).rawValue)
                Spacer()
            }
            .padding(.top, 30)
            .padding(.leading, 20)
            Button("Edit Info"){
                editUserFormData = dataStore.userList[0].dataForForm
                presentInfo.toggle()
            }
            .buttonStyle(.bordered)
            .padding(.top, 30)
            .padding(.leading, 170)
            Spacer()
        }
        .sheet(isPresented: $presentInfo){
            NavigationStack{
                UserForm(data: $editUserFormData)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel"){
                                presentInfo = false
                                editUserFormData = User.FormData()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button("Save"){
                                let newUser = User.update(dataStore.userList[0], from: editUserFormData)
                                dataStore.updateUser(newUser)
                                presentInfo = false
                                editUserFormData = User.FormData()
                            }
                        }
                    }
                    .toolbarBackground(.visible)
                    .toolbarColorScheme(.dark)
            }
        }
    }
    
}

struct Box: View {
    let headline: String
    let result: String
    
    var body: some View {
        HStack {
            Text(headline).font(.title2).bold()
            Text(result)
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo().environmentObject(DataStore())
    }
}
