//
//  ContentView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var store = BountyStore()
    var body: some View {
        TabView {
            AdminControlView().tabItem { Label("KILL", systemImage: "bolt.slash.fill") }
            TheGridView().tabItem { Label("GRID", systemImage: "circle.grid.cross") }
            VaultView().tabItem { Label("VAULT", systemImage: "cpu") }
            OperativeSetupView().tabItem { Label("DEPLOY", systemImage: "bolt.fill") }
        }.environment(store).tint(Theme.heroCyan)
    }
}
