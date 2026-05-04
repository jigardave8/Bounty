//
//  InfluencerHUDView.swift
//  Bounty
//
//  Created by BitDegree on 03/05/26.
//

import SwiftUI

struct InfluencerHUDView: View {
    @Environment(BountyStore.self) private var store
    let bounty: Bounty
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea() // Influencer sees camera via background
            VStack {
                HStack {
                    Text("LIVE MISSION: \(bounty.title)")
                        .padding().background(.ultraThinMaterial).cornerRadius(10)
                    Spacer()
                }
                Spacer()
                // The "Puppet-Master" Feedback
                HStack {
                    Text("O: \(store.liveO)").foregroundColor(Theme.heroCyan).padding().background(.black.opacity(0.5))
                    Spacer()
                    Text("X: \(store.liveX)").foregroundColor(Theme.chaosRed).padding().background(.black.opacity(0.5))
                }
                .font(.system(size: 24, weight: .bold))
                .sensoryFeedback(.impact(weight: .heavy), trigger: store.liveX) // Corrected syntax
            }.padding()
        }.onAppear { store.tuneIntoThermalFrequency(bountyId: bounty.id) }
    }
}
