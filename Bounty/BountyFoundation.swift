//
//  BountyFoundation.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI

// MARK: - Global Theme
struct Theme {
    static let voidBlack = Color.black
    static let heroCyan = Color(red: 0.0, green: 0.94, blue: 1.0)
    static let chaosRed = Color(red: 1.0, green: 0.16, blue: 0.16)
    
    static let tacticalSpring = Animation.spring(response: 0.35, dampingFraction: 0.6, blendDuration: 0)
    static let terminalFont = Font.system(size: 14, weight: .semibold, design: .monospaced)
}

// MARK: - Mock Models
struct Bounty: Identifiable, Hashable {
    let id: String // Changed to String to perfectly sync with Firebase Document ID
    let title: String
    let target: String
    let poolO: Int
    let poolX: Int
    let ytVideoId: String
}

// Mock Data updated
let mockBounties: [Bounty] = [
    Bounty(id: "mission_01_beta", title: "SLUMDOG CLEANUP", target: "Sector 7 Sewers", poolO: 450, poolX: 120, ytVideoId: "jfKfPfyJRdk"),
    Bounty(id: "mission_02_alpha", title: "URBAN PARKOUR 04", target: "Abandoned Factory", poolO: 200, poolX: 890, ytVideoId: "9X0Srx_yI7s")
]
