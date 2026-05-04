//
//  BountyApp.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI
import FirebaseCore // Added




class AppDelegate: NSObject, UIApplicationDelegate { func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool { FirebaseApp.configure(); return true } }

@main
struct BountyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene { WindowGroup { ContentView().preferredColorScheme(.dark) } }
}
