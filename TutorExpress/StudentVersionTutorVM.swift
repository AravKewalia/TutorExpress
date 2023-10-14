//
//  StudentVersionTutorVM.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 8/31/23.
//

import SwiftUI
import Firebase
 
struct studentVersionChatUser {
    let uid, email, fname, lname, role, credentials: String
}
 
class StudentVersionTutorVM: ObservableObject {
    @Published var errorMessage = ""
    @Published var chatUser: studentVersionChatUser?
    let tutorUID: String
     
    init(tutorUID: String) {
        self.tutorUID = tutorUID;
        print(tutorUID)
        fetchCurrentUser(tutorUID: tutorUID)
    }
    private func fetchCurrentUser(tutorUID: String) {
 
        Firestore.firestore().collection("users").document(tutorUID).getDocument { snapshot, error in
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
            let credentials = data["credentials"] as? String ?? ""
            
            print(lname)
            self.chatUser = studentVersionChatUser(uid: uid, email: email, fname: fname, lname: lname, role: role, credentials: credentials)
             
            
        }
    }
}

