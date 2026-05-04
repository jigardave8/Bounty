//
//  BountyFoundation.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

struct Theme {
    static let voidBlack = Color.black
    static let heroCyan = Color(red: 0.0, green: 0.94, blue: 1.0)
    static let chaosRed = Color(red: 1.0, green: 0.16, blue: 0.16)
    static let tacticalSpring = Animation.spring(response: 0.35, dampingFraction: 0.6, blendDuration: 0)
    static let terminalFont = Font.system(size: 14, weight: .semibold, design: .monospaced)
}

struct Bounty: Identifiable, Hashable {
    let id: String
    let title: String
    let target: String
    let poolO: Int
    let poolX: Int
    let ytVideoId: String
}

let mockBounties: [Bounty] = []
