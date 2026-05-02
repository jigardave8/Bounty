//
//  VaultView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct VaultView: View {
    @State private var rippleSize: CGFloat = 0
    let currentBalance: Int = 1250 // Fetched from Firestore

    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("VAULT: P2P ROUTING")
                    .font(Theme.terminalFont)
                    .foregroundColor(.gray)
                
                // Liquid Card
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.ultraThinMaterial)
                        .frame(height: 200)
                    
                    // Liquid Blob Simulation
                    Circle()
                        .fill(LinearGradient(colors: [Theme.heroCyan, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 150)
                        .blur(radius: 40)
                        .offset(x: rippleSize, y: -rippleSize/2)
                        .animation(Animation.easeInOut(duration: 4.0).repeatForever(), value: rippleSize)
                    
                    VStack(alignment: .leading) {
                        Text("TOTAL RESERVE")
                            .font(.caption).foregroundColor(.white.opacity(0.8))
                        Text("₹\(currentBalance)")
                            .font(.system(size: 48, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            Text("UPI BYPASS // ACTIVE")
                                .font(Theme.terminalFont)
                                .foregroundColor(.green)
                            Spacer()
                        }
                    }
                    .padding(24)
                }
                .padding()
                .onAppear { rippleSize = 60 }
                
                Button(action: initializeUPIIntent) {
                    HStack {
                        Image(systemName: "plus.diamond.fill")
                        Text("CHARGE RESERVE VIA UPI")
                    }
                    .font(.headline)
                    .foregroundColor(Theme.voidBlack)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Theme.heroCyan)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func initializeUPIIntent() {
        // DeepLink Generation logic. $0 Transaction Fees.
        // Requires info.plist URL Type entries for production.
        let amount = "500" // Hardcoded test payload
        guard let url = URL(string: "upi://pay?pa=yourvpa@upi&pn=BountySystem&cu=INR&am=\(amount)") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Fallback to Web UI Stripe Payment / Instruction UI")
        }
    }
}
