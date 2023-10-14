//
//  StudentConfirmation.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 8/15/23.
//



import SwiftUI
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth

struct StudentConfirmation: View {
    let db = Firestore.firestore()
    let studentUID : String
    let category: String
    let postUID: String
    @ObservedObject var tvm: TutorVM;
    @ObservedObject var vm: StudentVM;
    
    init(studentUID: String, postUID: String, category: String) {
        self.studentUID = studentUID;
        self.postUID = postUID
        self.category = category
        print(studentUID)
        vm = StudentVM(studentUID: studentUID)
        tvm = TutorVM()
    }
    
    

    var body: some View {
        ScrollView{
            HStack{
                Spacer();
                VStack{
                    Spacer()
                    Group{
                        VStack{
                            Text("Post Information:").font(.largeTitle).bold()
                        }
                        Spacer()
                        VStack{
                            Text("Student Name:").font(.headline)
                            Text((vm.chatUser?.fname ?? "fname") + " " + (vm.chatUser?.lname ?? "lname")).font(.subheadline)
                        }
                        Spacer()
                        VStack{
                            Text("Student Age: ").font(.headline)
                            Text(vm.chatUser?.age ?? "age").font(.subheadline)
                        }
                        Spacer()
                        VStack{
                            Text("Student Grade: ").font(.headline)
                            Text(vm.chatUser?.grade ?? "grade").font(.subheadline)
                        }
                        Spacer();
                        Button {
                            db.collection("users").document(studentUID).updateData([
                                "tutor name": ((tvm.chatUser?.fname ?? "fname") + " " + (tvm.chatUser?.lname ?? "lname"))
                            ]) { error in
                                if let error = error {
                                    print("Error updating value: \(error)")
                                } else {
                                    print("Value updated successfully")
                                }
                            }
                            
                            db.collection("users").document(studentUID).updateData([
                                "tutor uid": tvm.chatUser?.uid ?? "uid"
                            ]) { error in
                                if let error = error {
                                    print("Error updating value: \(error)")
                                } else {
                                    print("Value updated successfully")
                                }
                            }
                            
                            db.collection("users").document(tvm.chatUser?.uid ?? " ").updateData([
                                "student name": ((vm.chatUser?.fname ?? "fname") + " " + (vm.chatUser?.lname ?? "lname"))
                            ]) { error in
                                if let error = error {
                                    print("Error updating value: \(error)")
                                } else {
                                    print("Value updated successfully")
                                }
                            }
                            
                            db.collection("users").document(tvm.chatUser?.uid ?? " ").updateData([
                                "student uid": vm.chatUser?.uid ?? "uid"
                            ]) { error in
                                if let error = error {
                                    print("Error updating value: \(error)")
                                } else {
                                    print("Value updated successfully")
                                }
                            }
                            
                            db.collection(category).document(postUID).updateData([
                                "active": "Inactive"
                            ]) { error in
                                if let error = error {
                                    print("Error updating value: \(error)")
                                } else {
                                    print("Value updated successfully")
                                }
                            }
                            print("handle sign out")
                            try? Auth.auth().signOut()

                        } label: {
                            Text("Choose Student")
                        }.bold().foregroundColor(.white)
                            .padding(.vertical, 10)
                            .font(.system(size: 18, weight: .semibold)).padding(30).background(Color.teal)
                        
                        
                    }
                    Spacer();
                }
                Spacer();
                }
              
            }.background(
                LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                )
        }
    }

struct StudentConfirmation_Previews: PreviewProvider {
    @State static var studentUID = ""
    @State static var postUID = ""
    @State static var category = ""
    static var previews: some View {
        StudentConfirmation(studentUID: studentUID, postUID: postUID, category: category)
    }
}
