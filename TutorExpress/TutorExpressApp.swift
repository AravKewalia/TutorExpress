//
//  TutorExpressApp.swift
//  TutorExpress
//
//  Created by Kiran Kewalia on 7/6/23.
//

import SwiftUI
import Firebase


@main
struct TutorExpressApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
