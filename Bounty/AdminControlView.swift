//
//  AdminControlView.swift
//  Bounty
//
//  Created by BitDegree on 03/05/26.
//

import SwiftUI
import FirebaseFirestore

struct AdminControlView: View {
    @Environment(BountyStore.self) private var store
    
    var body: some View {
        List(store.activeBounties) { bounty in
            HStack {
                Text(bounty.title)
                Spacer()
                Button("KILL") {
                    Firestore.firestore().collection("bounties").document(bounty.id).updateData(["isActive": false])
                }.foregroundColor(.red)
            }
        }
    }
}
