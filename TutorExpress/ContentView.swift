import SwiftUI
import Firebase
 
struct ContentView: View {
    
    @State public var isUserCurrentlyLoggedOut: Bool = false
    @State public var student: Bool = false
    
    var body: some View {
        NavigationView {
            if(student == false && self.isUserCurrentlyLoggedOut) {
                TutorHomepage(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, student: $student)
            }
            else if (self.isUserCurrentlyLoggedOut) {
                StudentHomepage(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, student : $student)
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
