import SwiftUI
import Firebase
 
struct ContentView: View {
    
    @State private var isUserCurrentlyLoggedOut: Bool = false
    @State private var student: Bool = true
    
    var body: some View {
        NavigationView {
            if(student == false && self.isUserCurrentlyLoggedOut) {
                TutorHomepage(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
            }
            else if self.isUserCurrentlyLoggedOut {
                StudentHomepage(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
            }
            else {
                RegisterLogin(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, student: $student)
            }
        }
        
        
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
