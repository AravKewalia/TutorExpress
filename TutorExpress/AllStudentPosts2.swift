//
//  AllStudentPosts2.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 9/5/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AllStudentPosts2: View {
    @State private var topicChoice: String
    @State private var activity: String
    
    @ObservedObject private var viewModel: studentPostsStudentView
    @ObservedObject private var svm: LoggedInStudentVM
    
    init(topicChoice: String, activity: String) {
        self.topicChoice = topicChoice
        self.activity = activity
        viewModel = studentPostsStudentView(cat: topicChoice)
        svm = LoggedInStudentVM()
    }
    
    var body: some View {
        
        List(viewModel.posts) { Posters in
            if(Posters.active == activity && Posters.uid == svm.chatUser?.uid ?? "err") {
                HStack() {
                    VStack(alignment: .leading) {
                        Text(Posters.chapter).font(.title)
                        Text(Posters.topic).font(.subheadline)
                        Text(Posters.subject).font(.subheadline)
                    }
                }
            }
        }.navigationBarTitle("Posts")
            .onAppear() {
                self.viewModel.fetchData()
            }
}
}
