//
//  MainMessagesViewModel.swift
//  DevSwiftUI
//
//  Created by Cairocoders
//
 
import SwiftUI
import Firebase
 
struct lChatUser {
    let uid, email, fname, lname, role, tutorName, tutorUID, grade: String
}
 
class LoggedInStudentVM: ObservableObject {
     
    @Published var errorMessage = ""
    @Published var chatUser: lChatUser?
     
    init() {
        
        fetchCurrentUser()
    }
    private func fetchCurrentUser() {
 
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
         
         
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
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
            let tutorName = data["tutor name"] as? String ?? ""
            let tutorUID = data["tutor uid"] as? String ?? ""
            let grade = data["grade"] as? String ?? ""
            
            
            self.chatUser = lChatUser(uid: uid, email: email, fname: fname, lname: lname, role: role, tutorName: tutorName, tutorUID: tutorUID, grade: grade)
             
            //self.errorMessage = chatUser.profileImageUrl
             
        }
    }
}
