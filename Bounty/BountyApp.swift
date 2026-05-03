//
//  BountyApp.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI
import FirebaseCore // Added

// Add AppDelegate intercept for Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct BountyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // Added
//    @State private var store = BountyStore()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(store) // 2. Broadcast globally

                .preferredColorScheme(.dark)
        }
    }
}
