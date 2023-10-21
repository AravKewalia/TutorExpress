//
//  Homepag.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 7/11/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct StudentHomepage: View {
    let db = Firestore.firestore()
    @State var shouldShowLogOutOptions = false
    @ObservedObject private var vm = MainMessagesViewModel()
    @Binding var isUserCurrentlyLoggedOut : Bool
    @Binding var student: Bool
    
    @State var index = 0
    
    
    var body: some View {
        ScrollView {
            ZStack{
                VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Group{
                                Text("Student Homepage").font(.title).bold()
                                Spacer()
                                NavigationLink("All Posts") {
                                    AllStudentPosts();
                                }.font(.headline).bold()
                                    .padding(50)
                                    .background(Color.teal)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10).frame(width: 200, height: 150)
                                Spacer()
                                if(vm.chatUser?.tutorUID != "none") {
                                    NavigationLink("Current Tutor") {
                                        CurrentTutor(tutorU: vm.chatUser?.tutorUID ?? "hi")
                                    }.font(.headline)
                                        .padding(50)
                                        .background(Color.teal)
                                        .foregroundColor(Color.black).bold()
                                        .cornerRadius(10).frame(width: 200, height: 150)
                                    
                                    Spacer()
                                    Group{
                                        Button {
                                            print(vm.chatUser?.uid ?? "error")
                                            print(vm.chatUser?.tutorUID ?? "error")
                                            db.collection("users").document(vm.chatUser?.uid ?? "").updateData([
                                                "tutor name": "none"
                                            ]) { error in
                                                if let error = error {
                                                    print("Error updating value: \(error)")
                                                } else {
                                                    print("Value updated successfully")
                                                }
                                            }
                                            
                                            db.collection("users").document(vm.chatUser?.uid ?? "").updateData([
                                                "tutor uid": "none"
                                            ]) { error in
                                                if let error = error {
                                                    print("Error updating value: \(error)")
                                                } else {
                                                    print("Value updated successfully")
                                                }
                                            }
                                            
                                            db.collection("users").document(vm.chatUser?.tutorUID ?? "none").updateData([
                                                "student name": "none"
                                            ]) { error in
                                                if let error = error {
                                                    print("Error updating value: \(error)")
                                                } else {
                                                    print("Value updated successfully")
                                                }
                                            }
                                            
                                            db.collection("users").document(vm.chatUser?.tutorUID ?? "none").updateData([
                                                "student uid": "none"
                                            ]) { error in
                                                if let error = error {
                                                    print("Error updating value: \(error)")
                                                } else {
                                                    print("Value updated successfully")
                                                }
                                            }
                                            print("handle sign out")
                                            try? Auth.auth().signOut()
                                            self.isUserCurrentlyLoggedOut = false
                                            
                                        } label: {
                                            Text("Drop Tutor")
                                        }.font(.headline)
                                            .padding(50).bold()
                                            .background(Color.teal)
                                            .foregroundColor(Color.black)
                                            .cornerRadius(10).frame(width: 200, height: 150)
                                    }
                                }
                                Spacer();
                                NavigationLink("New Post") {
                                    NewStudentPost()
                                }.font(.headline)
                                    .padding(50).bold()
                                    .background(Color.teal)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10).frame(width: 200, height: 150)
                            }
                            Spacer()
                            Button("Sign Out") {
                                print("handle sign out")
                                try? Auth.auth().signOut()
                                self.isUserCurrentlyLoggedOut = false
                                self.student = false
                            }.font(.headline)
                                .padding(50)
                                .background(Color.teal)
                                .foregroundColor(Color.black).bold()
                                .cornerRadius(10).frame(width: 200, height: 150)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            
        }.background(LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        
    }
    
}

struct StudentHomepage_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    @State static var student = false
    static var previews: some View {
        StudentHomepage(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, student: $student)
    }
}
