//
//  MainMessagesViewModel.swift
//  DevSwiftUI
//
//  Created by Cairocoders
//
 
import SwiftUI
import Firebase
 
struct tutorChatUser {
    let uid, email, fname, lname, role, subject, credentials, studentName, studentUID: String
}
 
class TutorVM: ObservableObject {
     
    @Published var errorMessage = ""
    @Published var chatUser: tutorChatUser?
     
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
            let subject = data["subject"] as? String ?? ""
            let credentials = data["credentials"] as? String ?? ""
            let studentName = data["student name"] as? String ?? ""
            let studentUID = data["student uid"] as? String ?? "none"
            
            
            self.chatUser = tutorChatUser(uid: uid, email: email, fname: fname, lname: lname, role: role, subject: subject, credentials: credentials, studentName: studentName, studentUID: studentUID)
             
            //self.errorMessage = chatUser.profileImageUrl
             
        }
    }
}

