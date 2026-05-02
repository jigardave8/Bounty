//
//  ContentView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        // Tactical overrides for the native TabBar to mimic Liquid Glass
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        // Apply the ultraThinMaterial effect natively
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        // Active/Inactive tab text & icon styling
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Theme.heroCyan)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(Theme.heroCyan),
            .font: UIFont.monospacedSystemFont(ofSize: 10, weight: .bold)
        ]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.monospacedSystemFont(ofSize: 10, weight: .regular)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            TheGridView()
                .tabItem {
                    Image(systemName: "circle.grid.cross")
                    Text("GRID")
                }
            
            // NOTE: MissionHUDView is inherently accessed *through* TheGridView by tapping a Bounty.
            
            BriefingView()
                .tabItem {
                    Image(systemName: "folder.badge.gearshape")
                    Text("CONTRACTS")
                }
            
            VaultView()
                .tabItem {
                    Image(systemName: "cpu")
                    Text("VAULT")
                }
            
            LadderView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("LADDER")
                }
        }
        .tint(Theme.heroCyan) // Fallback tint for legacy rendering
    }
}
