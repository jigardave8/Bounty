//
//  OperativeSetupView.swift
//  Bounty
//
//  Created by BitDegree on 03/05/26.
//

import SwiftUI
import FirebaseFirestore

struct OperativeSetupView: View {
    @State private var ytLink: String = ""
    @State private var title: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("DEPLOY MISSION").font(.headline)
            TextField("YouTube Video ID", text: $ytLink).textFieldStyle(.roundedBorder).padding()
            TextField("Mission Title", text: $title).textFieldStyle(.roundedBorder).padding()
            Button("INITIALIZE FEED") {
                let db = Firestore.firestore()
                db.collection("bounties").addDocument(data: [
                    "title": title,
                    "ytVideoId": ytLink,
                    "isActive": true,
                    "poolO": 0,
                    "poolX": 0,
                    "target": "FIELD TEST"
                ])
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
