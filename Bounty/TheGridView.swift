//
//  TheGridView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct TheGridView: View {
    @Environment(BountyStore.self) private var store // Inject
      @State private var pulse: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.voidBlack.ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                              LazyVStack(spacing: 24) {
                                  ForEach(store.activeBounties) { bounty in // Map via Firebase Brain
                                      NavigationLink(destination: MissionHUDView(bounty: bounty)) {
                                          gridCell(for: bounty)
                                      }
                                  }
                              }
                              .padding()
                          }            }
            .navigationTitle("THERMAL GRID")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Theme.voidBlack, for: .navigationBar)
        }
    }
    
    private func gridCell(for bounty: Bounty) -> some View {
        ZStack(alignment: .bottomLeading) {
            // Simulated video thumbnail backdrop
            Color(white: 0.1)
                .frame(height: 220)
                .overlay(
                    LinearGradient(
                        colors: [.clear, Theme.voidBlack],
                        startPoint: .center, endPoint: .bottom
                    )
                )
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Circle()
                        .fill(bounty.poolO > bounty.poolX ? Theme.heroCyan : Theme.chaosRed)
                        .frame(width: 8, height: 8)
                        .shadow(color: bounty.poolO > bounty.poolX ? Theme.heroCyan : Theme.chaosRed, radius: 4)
                        .opacity(pulse ? 1 : 0.4)
                    
                    Text("LIVE REC")
                        .font(Theme.terminalFont)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                Text(bounty.title)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
            }
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                pulse.toggle()
            }
        }
    }
}
