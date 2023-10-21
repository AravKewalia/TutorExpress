import SwiftUI
import Firebase
import FirebaseDatabase

 
struct RegisterLogin: View {
    
    @State var ref: DatabaseReference!
    
    //universal
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var fname = ""
    @State var lname = ""
    @State var role = "Student or Tutor"
    @State var phoneNumber = ""
    
    //Student Specific
    @State var grade = ""
    @State var age = ""
    
    //Tutor Specific
    @State var subject = "Subject (Click to Change)"
    @State var credentials = ""
     
    @State private var shouldShowLoginAlert: Bool = false
     
    @State var StatusMessage = ""
    
    @State var roles = ""
     
    @Binding var isUserCurrentlyLoggedOut : Bool
    @Binding var student: Bool
    
   
     
    var body: some View {
        ScrollView {
 
            VStack(spacing: 16) {
                Text("Tutor-").bold().foregroundColor(Color.white).font(Font.title) + Text("X").bold().foregroundColor(Color.black
                ).font(Font.title).italic() + Text("Press").bold().foregroundColor(Color.white).font(Font.title)

                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("Login")
                        .tag(true)
                    Text("Create Account")
                        .tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                 
                if !isLoginMode {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .padding()
                            .foregroundColor(Color(.label))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black, lineWidth: 3)
                    )
                    Group {
                        TextField("First Name", text: $fname)
                        
                        TextField("Last Name", text: $lname)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.default)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                        Menu {
                            Button {
                                role = "Student"
                            } label: {
                                Text("Student")
                            }
                            
                            Button {
                                role = "Tutor"
                            } label: {
                                Text("Tutor")
                            }
                            
                        } label: {
                            Label {
                                Text("\(role)")
                            } icon: {
                                Image(systemName: "work")
                            }

                        }
                        if(role == "Student") {
                            TextField("Age (Must be between 5 and 21)", text: $age)
                            if(Int(age) ?? 0 <= 5 || Int(age) ?? 0 >= 21 || Int(age) ?? 0 == 0) {
                                Text("Age is out of bounds").font(Font.caption)
                            }
                            TextField("Grade (Must be between 1 and 12)", text: $grade)
                            if(Int(grade) ?? 0 >= 12 || Int(grade) ?? 0 <= 1 || Int(grade) ?? 0 == 0) {
                                Text("Grade is out of bounds").font(Font.caption)
                            }

                        }
                        if(role == "Tutor") {
                            Menu {
                                Button {
                                    subject = "Biology"
                                } label: {
                                    Text("Biology")
                                }
                                
                                Button {
                                    subject = "Algebra"
                                } label: {
                                    Text("Algebra")
                                }
                                
                                Button {
                                    subject = "Physics"
                                } label: {
                                    Text("Physics")
                                }
                                
                                Button {
                                    subject = "Programming"
                                } label: {
                                    Text("Programming")
                                }
                                
                                Button {
                                    subject = "English"
                                } label: {
                                    Text("English")
                                }
                                
                                Button {
                                    subject = "Geometry"
                                } label: {
                                    Text("Geometry")
                                }
                            } label: {
                                Label {
                                    Text("\(subject)")
                                } icon: {
                                    Image(systemName: "book")
                                }

                            }
                            TextField("Credentials", text: $credentials)
                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    if(role == "Tutor") {
                        Button {
                            handleAction()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Create Account")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                            }.background(Color.green)
                            
                        }.cornerRadius(10)
                    }
                    else if (role == "Student" && Int(age) ?? 0 >= 5 && Int(age) ?? 0 <= 21 && Int(grade) ?? 0 >= 1&&Int(grade) ?? 0<=12)
                    {
                        Button {
                            handleAction()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Create Account")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                            }.background(Color.green)
                            
                        }.cornerRadius(10)
                    }
                }else{
                    Image("Login")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .cornerRadius(64)
                     
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                     
                    Button {
                        loginUser()
                        return;
                        }
                     label: {
                        HStack {
                            Spacer()
                            Text("Login")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                        }.background(Color.green)
   
                    }.cornerRadius(10)
                    .alert(isPresented: $shouldShowLoginAlert) {
                        Alert(title: Text("Email/Password incorrect"))
                    }
                }
                 
                Text(self.StatusMessage)
                    .foregroundColor(Color.white)
                 
            }.padding()
        } //End ScrollView
        .navigationViewStyle(StackNavigationViewStyle())
        .background(
            LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        )
    }
     
    private func loginUser() {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.StatusMessage = "Failed to login user: \(err)"
                self.shouldShowLoginAlert = true
                return
            }
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.StatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            
            
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(result?.user.uid ?? "")
            docRef.getDocument { (document, error) in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        print("data", data)
                        self.roles = data["role"] as? String ?? ""
                        print(roles)
                        if(roles == "Student") {
                            self.student = true
                        }
                        else if (roles == "Tutor") {
                            self.student = false
                        }
                        print(roles)
                        print(self.student)
                        self.isUserCurrentlyLoggedOut = true

                    }
                }
            }
            
        }
        
    }
                                               
                                               
    private func handleAction() {
        createNewAccount()
    }
      
    
    private func tog() {
        student.toggle()
    }
    
//    private func checkRole() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        var ref: DatabaseReference!
//
//        ref.child("users/\(uid)/username").getData(completion:  { error, snapshot in
//          guard error == nil else {
//            print(error!.localizedDescription)
//            return;
//          }
//          let userName = snapshot.value as? String ?? "Unknown";
//        });
//
//    }
    
    
    
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.StatusMessage = "Failed to create user: \(err)"
                return
            }
             
            print("Successfully created user: \(result?.user.uid ?? "")")
   
            self.StatusMessage = "Successfully created user"
             
            self.storeUserInformation()
        }
    }
     
    private func storeUserInformation() {
        if(role == "Student") {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let userData = ["fname": self.fname, "lname": self.lname, "email": self.email, "age": self.age, "phoneNum": self.phoneNumber, "role": self.role, "grade": self.grade, "uid": uid, "tutor name": "none", "tutor uid": "none"]
            Firestore.firestore().collection("users")
                .document(uid).setData(userData) { err in
                    if let err = err {
                        print(err)
                        self.StatusMessage = "\(err)"
                        return
                    }
                    
                    print("Success")
                }
        }
        else if (role == "Tutor") {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let userData = ["role": self.role, "fname": self.fname, "lname": self.lname, "phoneNum": self.phoneNumber, "email": self.email, "subject": self.subject, "credentials": self.credentials, "uid": uid, "student name": "none", "student uid": "none"]
            Firestore.firestore().collection("users")
                .document(uid).setData(userData) { err in
                    if let err = err {
                        print(err)
                        self.StatusMessage = "\(err)"
                        return
                    }
                    print("Success")
                }

        }
        self.role = "Student or Tutor"
        self.fname = ""
        self.lname = ""
        self.email = ""
        self.password = ""
        self.phoneNumber = ""
        self.age = "Age (Must be between 5 and 21)"
        self.grade = "Grade (Must be between 1 and 12)"
        self.subject = ""
        self.credentials = ""
    }
}
 
struct LoginRegister_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    @State static var student = false
    static var previews: some View {
        RegisterLogin(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, student: $student)
    }
}
