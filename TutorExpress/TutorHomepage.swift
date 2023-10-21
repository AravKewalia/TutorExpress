//
//  Homepag.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 7/11/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct TutorHomepage: View {
    let db = Firestore.firestore()
    @State var shouldShowLogOutOptions = false
    @Binding var isUserCurrentlyLoggedOut : Bool
    @Binding var student: Bool
    
    @State var index = 0
    @ObservedObject private var viewModel = studentPosts()
    @ObservedObject private var vm = MainMessagesViewModel()

   

    var body: some View {
        ScrollView {
            ZStack{
                VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Text("Tutor Homepage").font(.title).bold()
                            Spacer()
                            if(vm.chatUser?.studentUID == "none") {
                                NavigationLink("Student Posts")
                                {
                                    PostWall()
                                }.font(.headline).bold()
                                    .padding(50)
                                    .background(Color.teal)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10).frame(width: 200, height: 150)
                            }
                            Spacer()
                            if(vm.chatUser?.studentUID != "none") {
                                NavigationLink("Current Student")
                                {
                                    CurrentStudent(studentU: vm.chatUser?.studentUID ?? "none")
                                }.font(.headline).bold()
                                    .padding(50)
                                    .background(Color.teal)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10).frame(width: 200, height: 150)
                                Spacer()
                                Button {
                                    db.collection("users").document(vm.chatUser?.uid ?? "").updateData([
                                        "student name": "none"
                                    ]) { error in
                                        if let error = error {
                                            print("Error updating value: \(error)")
                                        } else {
                                            print("Value updated successfully")
                                        }
                                    }

                                    db.collection("users").document(vm.chatUser?.uid ?? "").updateData([
                                        "student uid": "none"
                                    ]) { error in
                                        if let error = error {
                                            print("Error updating value: \(error)")
                                        } else {
                                            print("Value updated successfully")
                                        }
                                    }

                                    db.collection("users").document(vm.chatUser?.studentUID ?? "").updateData([
                                        "tutor name": "none"
                                    ]) { error in
                                        if let error = error {
                                            print("Error updating value: \(error)")
                                        } else {
                                            print("Value updated successfully")
                                        }
                                    }

                                    db.collection("users").document(vm.chatUser?.studentUID ?? "").updateData([
                                        "tutor uid": "none"
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
                                    Text("Drop Student")
                                }.font(.headline)
                                    .padding(50).bold()
                                    .background(Color.teal)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10).frame(width: 200, height: 150)
                            }
                            Spacer();
                            Button("Sign Out") {
                                print("handle sign out")
                                try? Auth.auth().signOut()
                                self.isUserCurrentlyLoggedOut = false
                                self.student = false
                            }.font(.headline).bold()
                                .padding(50)
                                .background(Color.teal)
                                .foregroundColor(Color.black)
                                .cornerRadius(10).frame(width: 200, height: 150)
                            Spacer();
                        }
                        Spacer()
                    }
                }
            }
            
        }.background(LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        
    }
    
}

struct TutorHomepage_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    @State static var student = false
    static var previews: some View {
        TutorHomepage(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, student : $student)
    }
}
