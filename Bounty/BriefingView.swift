//
//  BriefingView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct BriefingView: View {
    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Text("MISSION BRIEFING").font(.title).bold().foregroundColor(Theme.heroCyan)
                Text("OBJECTIVE: SURVIVAL & LABOR").font(Theme.terminalFont).foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
    }
}
