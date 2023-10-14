//
//  StudentPosts.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 7/15/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct Posters: Identifiable {
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

class studentPostsStudentView: ObservableObject {

    @Published var posts = [Posters]()
    @ObservedObject private var vm = TutorVM()
    @State var cat: String
    
    let db = Firestore.firestore()
    
    init(cat: String) {
        self.cat = cat;
    }

    func fetchData() {
        
            let z = cat
            
            db.collection(z).addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.posts = documents.map { (querySnapshot) -> Posters in
                    let data = querySnapshot.data()
                    let chapter = data["chapter"] as? String ?? ""
                    let topic = data["topic"] as? String ?? ""
                    let subject = data["subject"] as? String ?? ""
                    let active = data["active"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let code = data["code"] as? String ?? ""
                    
                    return Posters(chapter: chapter, subject: subject, active: active, topic: topic, uid: uid, category: z, code: code)
                  
                }
            }
    }
}



