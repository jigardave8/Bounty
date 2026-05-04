//
//  TheGridView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct TheGridView: View {
    @Environment(BountyStore.self) private var store
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.voidBlack.ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(store.activeBounties) { bounty in
                            NavigationLink(destination: MissionHUDView(bounty: bounty)) {
                                VStack(alignment: .leading) {
                                    Text(bounty.title).font(.headline).foregroundColor(.white)
                                    Text(bounty.target).font(Theme.terminalFont).foregroundColor(.gray)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("THERMAL GRID")
        }
    }
}
