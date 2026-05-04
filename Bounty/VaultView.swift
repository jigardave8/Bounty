//
//  VaultView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct VaultView: View {
    @Environment(BountyStore.self) private var store
    
    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            VStack(spacing: 20) {
                Text("VAULT RESERVE").font(Theme.terminalFont).foregroundColor(.gray)
                Text("₹\(store.vaultReserve)")
                    .font(.system(size: 50, weight: .black, design: .monospaced))
                    .foregroundColor(Theme.heroCyan)
                
                Button("TOP UP VIA UPI") {
                    let url = URL(string: "upi://pay?pa=test@upi&pn=BountySystem")!
                    UIApplication.shared.open(url)
                }
                .padding().background(Color.white.opacity(0.1)).cornerRadius(8)
            }
        }
    }
}
