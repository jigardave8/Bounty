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
                Text("OPERATIVE LADDER").font(.title2).bold().foregroundColor(.white)
                Spacer()
                Text("LEVEL: VILLAGE HUSTLER").foregroundColor(Theme.heroCyan)
            }
            .padding()
        }
    }
}
