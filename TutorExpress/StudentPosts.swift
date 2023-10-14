//
//  StudentPosts.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 7/15/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct Post: Identifiable {
    var id: String = UUID().uuidString
    var chapter: String
    var subject: String
    var active: String
    var topic: String
    var uid: String
    var category: String
    var code: String
}



import Foundation
import FirebaseFirestore

class studentPosts: ObservableObject {

    @Published var posts = [Post]()
    @ObservedObject private var vm = TutorVM()
    
    let db = Firestore.firestore()

    func fetchData() {
        let x = vm.chatUser?.subject ?? "w"
        let y = "Posts"
        let z = x + "" + y
        
        db.collection(z).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.posts = documents.map { (querySnapshot) -> Post in
                let data = querySnapshot.data()
                let chapter = data["chapter"] as? String ?? ""
                let topic = data["topic"] as? String ?? ""
                let subject = data["subject"] as? String ?? ""
                let active = data["active"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                let code = data["code"] as? String ?? ""
                
                return Post(chapter: chapter, subject: subject, active: active, topic: topic, uid: uid, category: z, code: code)
              
            }
        }
    }
}




