//
//  LadderView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct LadderView: View {
    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            
            VStack {
                // Profile Block
                VStack(spacing: 8) {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 100, height: 100)
                        .overlay(Image(systemName: "waveform.badge.magnifyingglass").foregroundColor(Theme.heroCyan))
                    
                    Text("OPERATIVE 092")
                        .font(.title2).bold().foregroundColor(.white)
                    Text("LEVEL: VILLAGE HUSTLER")
                        .font(Theme.terminalFont).foregroundColor(Theme.chaosRed)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Zero-to-Hero Graph (Abstracted visual stat placeholder)
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.05))
                        .frame(height: 200)
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        karmaBar(value: 80, color: Theme.heroCyan, label: "HERO")
                        karmaBar(value: 40, color: Theme.chaosRed, label: "MAV")
                        karmaBar(value: 120, color: Color.yellow, label: "XP")
                    }
                    .padding(.bottom, 20)
                }
                .padding()
                
                Spacer()
                
                Button(action: {}) {
                    Text("PLEDGE LOCAL BOUNTY // BECOME HERO")
                        .font(.system(size: 14, weight: .black))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Theme.heroCyan, lineWidth: 1))
                        .cornerRadius(12)
                }
                .padding()
            }
        }
    }
    
    private func karmaBar(value: CGFloat, color: Color, label: String) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 40, height: value)
            Text(label)
                .font(Theme.terminalFont).foregroundColor(.gray)
        }
    }
}
