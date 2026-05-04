//
//  MissionHUDView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI
import WebKit

// WKWebView Wrapper


import SwiftUI

struct MissionHUDView: View {
    @Environment(BountyStore.self) private var store
    let bounty: Bounty
    @State private var jamTrigger: Int = 0

    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Mission Header
                VStack(spacing: 8) {
                    Text("ACTIVE MISSION")
                        .font(Theme.terminalFont)
                        .foregroundColor(.gray)
                    Text(bounty.title.uppercased())
                        .font(.system(size: 28, weight: .black, design: .monospaced))
                        .foregroundColor(.white)
                }
                .padding(.top, 60)
                
                // Watch Button (The Launcher)
                Button(action: launchYouTube) {
                    HStack {
                        Image(systemName: "play.rectangle.fill")
                        Text("LAUNCH REALITY FEED")
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Theme.heroCyan)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Thermal Action Pool Data
                VStack(spacing: 20) {
                    HStack {
                        Text("O-POOL: \(store.liveO)")
                            .font(Theme.terminalFont)
                            .foregroundColor(Theme.heroCyan)
                        Spacer()
                        Text("X-POOL: \(store.liveX)")
                            .font(Theme.terminalFont)
                            .foregroundColor(Theme.chaosRed)
                    }
                    .padding(.horizontal)
                    
                    // Interaction Deck
                    HStack(spacing: 60) {
                        Image(systemName: "largecircle.fill.circle")
                            .font(.system(size: 60))
                            .foregroundColor(Theme.heroCyan)
                            .gesture(
                                DragGesture().onEnded { val in
                                    if val.translation.width > 50 { _ = store.dispatchThermalPulse(bountyId: bounty.id, isHero: true) }
                                }
                            )
                        
                        Image(systemName: "xmark.shield.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Theme.chaosRed)
                            .gesture(
                                DragGesture().onEnded { val in
                                    if val.translation.width < -50 {
                                        if !store.dispatchThermalPulse(bountyId: bounty.id, isHero: false) { jamTrigger += 1 }
                                    }
                                }
                            )
                            .sensoryFeedback(.error, trigger: jamTrigger)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear { store.tuneIntoThermalFrequency(bountyId: bounty.id) }
        .onDisappear { store.dropThermalFrequency(bountyId: bounty.id) }
    }
    
    private func launchYouTube() {
        let urlString = "https://www.youtube.com/watch?v=\(bounty.ytVideoId)"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
