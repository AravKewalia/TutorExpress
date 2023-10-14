//
//  PostWall.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 7/15/23.

import SwiftUI

struct PostWall: View {
    @ObservedObject private var viewModel = studentPosts()
    
    var body: some View {
 
                    List(viewModel.posts) { Post in
                        if(Post.active == "Active") {
                            HStack() {
                                VStack(alignment: .leading) {
                                    Text(Post.chapter).font(.title)
                                    Text(Post.topic).font(.subheadline)
                                    Text(Post.subject).font(.subheadline)
                                    
                                }
                                Spacer()
                                NavigationLink("")
                                {
                                    StudentConfirmation(studentUID: Post.uid, postUID: Post.code, category: Post.category)
                                }
                            }
                        }
                    }.navigationBarTitle("Posts")
                        .onAppear() {
                            self.viewModel.fetchData()
                        }
    }
}
struct PostWall_Previews: PreviewProvider {
    static var previews: some View {
        PostWall()
    }
}
