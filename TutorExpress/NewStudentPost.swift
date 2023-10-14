//
//  NewStudentPost.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 7/11/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
struct NewStudentPost: View {
    @State var subject = "Click Here to Choose"
    @ObservedObject private var vm = LoggedInStudentVM()
    @State var chapter = ""
    @State var topic = ""
    @State var urgency = Date()
    @State var postCat = ""
    @State var stored = false;
    
    
    var body: some View {
        ScrollView {
            ZStack{
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Text("New Post").font(Font.largeTitle).bold().italic().padding(20)
                            Text((vm.chatUser?.fname ?? "error") + "'s Grade Level: " + (vm.chatUser?.grade ?? "error")).padding(20)
                            Text("Subject").font(Font.subheadline)
                            
                            Menu {
                                Button {
                                    subject = "Biology"
                                    postCat = "BiologyPosts"
                                } label: {
                                    Text("Biology")
                                }
                                
                                Button {
                                    subject = "Algebra"
                                    postCat = "AlgebraPosts"

                                } label: {
                                    Text("Algebra")
                                }
                                
                                Button {
                                    subject = "Physics"
                                    postCat = "PhysicsPosts"

                                } label: {
                                    Text("Physics")
                                }
                                
                                Button {
                                    subject = "Programming"
                                    postCat = "ProgrammingPosts"

                                } label: {
                                    Text("Programming")
                                }
                                
                                Button {
                                    subject = "English"
                                    postCat = "EnglishPosts"

                                } label: {
                                    Text("English")
                                }
                                
                                Button {
                                    subject = "Geometry"
                                    postCat = "GeometryPosts"

                                } label: {
                                    Text("Geometry")
                                }
                            } label: {
                                Label {
                                    Text("\(subject)")
                                } icon: {
                                    Image(systemName: "book")
                                }

                            } //Subject
                            
                            TextField("Chapter (Ex: DNA)", text: $chapter).background(Color.white)
                            
                            TextField("Topic (Ex: Replication)", text: $topic).background(Color.white)
                            
                            DatePicker(
                                "Urgency:",
                                selection: $urgency,
                                displayedComponents: [.date]
                            )
                            
                            if(subject != "Click Here to Choose" && chapter != "" && topic != "") {
                                Button {
                                    storeStudentPost()
                                    stored = true
                                    chapter = ""
                                    topic = ""
                                    subject = "Click Here to Choose"
                                } label: {
                                    Text("Post")
                                }.foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 18, weight: .semibold))
                                    .background(Color.teal)
                                
                            }
                            
                            if(stored == true) {
                                Text("Post successfully stored")
                            }
                            
                            
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            
        }.background(
            LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        
    }
    
    
    private func storeStudentPost() {
        let code = randomString(length: 15);
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["subject": subject, "chapter": chapter, "topic": topic, "uid": uid, "active": "Active", "code": code]
        Firestore.firestore().collection(postCat)
            .document(code).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
        
        
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

struct NewStudentPost_Previews: PreviewProvider {
    static var previews: some View {
        NewStudentPost()
    }
}
