//
//  AllStudentPosts.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 9/4/23.
//

import SwiftUI

struct AllStudentPosts: View {
    @ObservedObject private var EnglishviewModel = studentPostsStudentView(cat: "EnglishPosts")
    @ObservedObject private var AlgebraviewModel = studentPostsStudentView(cat: "AlgebraPosts")
    @ObservedObject private var BiologyviewModel = studentPostsStudentView(cat: "BiologyPosts")
    @ObservedObject private var GeometryviewModel = studentPostsStudentView(cat: "GeometryPosts")
    @ObservedObject private var PhysicsviewModel = studentPostsStudentView(cat: "PhysicsPosts")
    @ObservedObject private var ProgrammingviewModel = studentPostsStudentView(cat: "ProgrammingPosts")

    @State var choice = ""
    
    @State var topicChoice = "Post Topic (Click here)"
    @State var activity = "Active or Inactive (Click here)"

    var body: some View {
        ScrollView{
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("Enter post data").font(.title)
                        .padding(30).bold()
                        .background(Color.teal)
                        .foregroundColor(Color.black)
                        .cornerRadius(10).frame(width: 350, height: 150)
                    Spacer()
                    Menu {
                        Button {
                            topicChoice = "PhysicsPosts"
                        } label: {
                            Text("Physics Posts")
                        }
                        
                        Button {
                            topicChoice = "AlgebraPosts"
                        } label: {
                            Text("Algebra Posts")
                        }
                        
                        Button {
                            topicChoice = "BiologyPosts"
                        } label: {
                            Text("Biology Posts")
                        }
                        
                        Button {
                            topicChoice = "GeometryPosts"
                        } label: {
                            Text("Geometry Posts")
                        }
                        
                        Button {
                            topicChoice = "ProgrammingPosts"
                        } label: {
                            Text("Programming Posts")
                        }
                        
                        Button {
                            topicChoice = "EnglishPosts"
                        } label: {
                            Text("English Posts")
                        }
                        
                    } label: {
                        Label {
                            Text("\(topicChoice)")
                        } icon: {
                            Image(systemName: "work")
                        }
                        
                    }.font(.headline)
                        .padding(20).bold()
                        .background(Color.teal)
                        .foregroundColor(Color.black)
                        .cornerRadius(10).frame(width: 300, height: 150)
                    Spacer()
                    Menu {
                        Button {
                            activity = "Active"
                        } label: {
                            Text("Active")
                        }
                        
                        Button {
                            activity = "Inactive"
                        } label: {
                            Text("Inactive")
                        }
                        
                    } label: {
                        Label {
                            Text("\(activity)")
                        } icon: {
                            Image(systemName: "work")
                        }
                    }.font(.headline)
                        .padding(20).bold()
                        .background(Color.teal)
                        .foregroundColor(Color.black)
                        .cornerRadius(10).frame(width: 300, height: 150)
                    Spacer()
                    if(activity != "Active or Inactive (Click here)" && topicChoice != "Post Topic (Click here)") {
                        NavigationLink("Go") {
                            AllStudentPosts2(topicChoice: topicChoice, activity: activity)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }.background(LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
}

struct AllStudentPosts_Previews: PreviewProvider {
    static var previews: some View {
        AllStudentPosts()
    }
}
