//
//  BountyApp.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

@main
struct BountyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Force dark mode at the root to protect the Void aesthetic
                            .preferredColorScheme(.dark) 
        }
    }
}
