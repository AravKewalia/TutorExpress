//
//  MainMessagesViewModel.swift
//  DevSwiftUI
//
//  Created by Cairocoders
//
 
import SwiftUI
import Firebase
 
struct studentChatUser {
    let uid, age, email, fname, grade, lname, role, tutorName, tutorUID: String
}
 
class StudentVM: ObservableObject {
    @Published var errorMessage = ""
    @Published var chatUser: studentChatUser?
    let studentUID: String
     
    init(studentUID: String) {
        self.studentUID = studentUID;
        print(studentUID)
        fetchCurrentUser(studentUID: studentUID)
    }
    private func fetchCurrentUser(studentUID: String) {
 
        Firestore.firestore().collection("users").document(studentUID).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
             
            self.errorMessage = "123"
             
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
                 
            }
            self.errorMessage = "Data: \(data.description)"
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let fname = data["fname"] as? String ?? ""
            let lname = data["lname"] as? String ?? ""
            let role = data["role"] as? String ?? ""
            let age = data["age"] as? String ?? ""
            let grade = data["grade"] as? String ?? ""
            let tutorName = data["tutor name"] as? String ?? ""
            let tutorUID = data["tutor uid"] as? String ?? ""
            
            print(lname)
            self.chatUser = studentChatUser(uid: uid, age: age, email: email, fname: fname, grade: grade, lname: lname, role: role, tutorName: tutorName, tutorUID: tutorUID)
             
            
        }
    }
}

