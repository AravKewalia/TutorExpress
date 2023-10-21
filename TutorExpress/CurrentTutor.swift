//
//  CurrentTutor.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 8/30/23.
//
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseDatabase
struct CurrentTutor: View {
    @ObservedObject var vm: LoggedInStudentVM;
    @ObservedObject var tvm: StudentVersionTutorVM;
    
    init(tutorU: String) {
        vm = LoggedInStudentVM();
        tvm = StudentVersionTutorVM(tutorUID: tutorU)
    }
    
    
    var body: some View {
        ScrollView{
            HStack{
                Spacer()
                VStack {
                    Spacer()
                    Text("Current Tutor's Name").bold().font(.title).padding(50)
                        .background(Color.blue)
                        .foregroundColor(Color.green)
                        .cornerRadius(10).frame(width: 400, height: 150)
                    Text(vm.chatUser?.tutorName ?? "none").bold().font(.headline).padding(20)
                        .background(Color.blue)
                        .foregroundColor(Color.green)
                        .cornerRadius(10).frame(width: 200, height: 150)
                    Spacer()
                    Text("Current Tutor's Email").bold().font(.title).padding(50)
                        .background(Color.blue)
                        .foregroundColor(Color.green)
                        .cornerRadius(10).frame(width: 400, height: 150)
                    Text(tvm.chatUser?.email ?? "none").bold().font(.headline).padding(20)
                        .background(Color.blue)
                        .foregroundColor(Color.green)
                        .cornerRadius(10).frame(width: 200, height: 150)
                    Spacer()
                    Text("Current Tutor's Phone Number").bold().font(.title).padding(50)
                        .background(Color.blue)
                        .foregroundColor(Color.green)
                        .cornerRadius(10).frame(width: 400, height: 150)
                    Text(tvm.chatUser?.phoneNum ?? "none").bold().font(.headline).padding(20)
                        .background(Color.blue)
                        .foregroundColor(Color.green)
                        .cornerRadius(10).frame(width: 200, height: 150)
                    Spacer()
                    Text("Current Tutor's Credentials").bold().font(.headline).padding(50)
                        .background(Color.blue)
                        .foregroundColor(Color.green)
                        .cornerRadius(10).frame(width: 400, height: 150)
                    Text(tvm.chatUser?.credentials ?? "none").bold().font(.headline).padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 200, height: 200)
                   
                    Spacer()
                }
                Spacer()
            }
        }.background(LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
}
struct CurrentTutor_Previews: PreviewProvider {
    @State static var tutorU = ""
    static var previews: some View {
        CurrentTutor(tutorU: tutorU)
    }
}



