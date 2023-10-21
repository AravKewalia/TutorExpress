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
struct CurrentStudent: View {
    @ObservedObject var vm: StudentVM;
    @ObservedObject var tvm: TutorVM;
    
    init(studentU: String) {
        vm = StudentVM(studentUID: studentU);
        tvm = TutorVM();
    }
    
    
    var body: some View {
        ScrollView{
            HStack{
                Spacer()
                VStack {
                    Spacer()
                    VStack{
                        Text("Current Student's Name").bold().font(.headline).padding(50)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 400, height: 150)
                        Text(tvm.chatUser?.studentName ?? "none").bold().font(.subheadline).padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 200, height: 150)
                    }
                    Spacer()
                    VStack{
                        Text("Current Student's Email").bold().font(.headline).padding(50)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 400, height: 150)
                        Text(vm.chatUser?.email ?? "none").bold().font(.subheadline).padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 200, height: 150)
                    }
                    Spacer()
                    VStack{
                        Text("Current Student's Grade").bold().font(.headline).padding(50)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 400, height: 150)
                        Text(vm.chatUser?.grade ?? "none").bold().font(.subheadline).padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 200, height: 150)
                    }
                    Spacer()
                    VStack{
                        Text("Current Student's Phone Number").bold().font(.headline).padding(50)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 400, height: 150)
                        Text(vm.chatUser?.phoneNum ?? "none").bold().font(.subheadline).padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 200, height: 150)
                    }
                    Spacer()
                    VStack{
                        Text("Current Student's Age").bold().font(.headline).padding(50)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 400, height: 150)
                        Text(vm.chatUser?.age ?? "none").bold().font(.subheadline).padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.green)
                            .cornerRadius(10).frame(width: 200, height: 150)
                    }
                    Spacer()
                }
                Spacer()
            }
        }.background(LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
}
struct CurrentStudent_Previews: PreviewProvider {
    @State static var studentU = ""
    static var previews: some View {
        CurrentStudent(studentU: studentU)
    }
}



