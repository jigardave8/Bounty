//
//  BriefingView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct BriefingView: View {
    let secretDocument: String = "TARGET IDENTIFIED\nCLASSIFICATION: DIRTY JOB\nREWARD SPONSOR: ZOMATO\nDIRECTIVE: DISTRIBUTE FOOD SURPLUS."
    @State private var decryptedText: String = ""
    @State private var isDecrypted: Bool = false
    
    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("CONTRACT DOSSIER")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Theme.heroCyan)
                    .tracking(2.0)
                
                Divider().background(Color.gray)
                
                ScrollView {
                    Text(decryptedText)
                        .font(Theme.terminalFont)
                        .foregroundColor(.white)
                        .lineSpacing(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                Button(action: { }) {
                    Text(isDecrypted ? "ACCEPT TERMS" : "DECRYPTING...")
                        .font(Theme.terminalFont)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isDecrypted ? Theme.heroCyan : Color.gray)
                        .foregroundColor(Theme.voidBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(!isDecrypted)
            }
            .padding()
        }
        .onAppear { decryptEffect() }
    }
    
    private func decryptEffect() {
        let chars = Array(secretDocument)
        let alphanumerics = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*"
        
        Task {
            for index in 0...chars.count {
                var tempString = ""
                // Add valid chars
                if index > 0 { tempString += String(chars[0..<index]) }
                // Scramble remainder
                for _ in index..<chars.count {
                    if let rand = alphanumerics.randomElement() { tempString.append(rand) }
                }
                
                await MainActor.run { decryptedText = tempString }
                try? await Task.sleep(nanoseconds: 30_000_000) // 30ms glitch per cycle
            }
            await MainActor.run { isDecrypted = true }
        }
    }
}
