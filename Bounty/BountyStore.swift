//
//  BountyStore.swift
//  Bounty
//
//  Created by BitDegree on 03/05/26.
//

import SwiftUI
import FirebaseFirestore
import FirebaseDatabase



@Observable
class BountyStore {
    var activeBounties: [Bounty] = []
    var liveO: Int = 0
    var liveX: Int = 0
    var vaultReserve: Int = 1000
    
    @ObservationIgnored private var db = Firestore.firestore()
    @ObservationIgnored private var rtdb = Database.database(url: "https://bounty-d54d6-default-rtdb.europe-west1.firebasedatabase.app").reference()
    @ObservationIgnored private var pulseHandle: DatabaseHandle?
    
    init() { fetchGridBounties() }
    
    func fetchGridBounties() {
        db.collection("bounties").whereField("isActive", isEqualTo: true)
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let docs = snapshot?.documents else { return }
                self?.activeBounties = docs.map { doc in
                    let d = doc.data()
                    return Bounty(id: doc.documentID, title: d["title"] as? String ?? "", target: d["target"] as? String ?? "", poolO: d["poolO"] as? Int ?? 0, poolX: d["poolX"] as? Int ?? 0, ytVideoId: d["ytVideoId"] as? String ?? "")
                }
            }
    }
    
    func tuneIntoThermalFrequency(bountyId: String) {
        pulseHandle = rtdb.child("missions/\(bountyId)").observe(.value) { [weak self] snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            Task { @MainActor in
                self?.liveO = dict["poolO"] as? Int ?? 0
                self?.liveX = dict["poolX"] as? Int ?? 0
            }
        }
    }
    
    func dropThermalFrequency(bountyId: String) {
        if let handle = pulseHandle { rtdb.child("missions/\(bountyId)").removeObserver(withHandle: handle) }
    }
    
    func dispatchThermalPulse(bountyId: String, isHero: Bool, tipAmount: Int = 10) -> Bool {
        guard vaultReserve >= tipAmount else { return false }
        Task { @MainActor in self.vaultReserve -= tipAmount }
        let ref = rtdb.child("missions/\(bountyId)/\(isHero ? "poolO" : "poolX")")
        ref.runTransactionBlock({ data in
            var val = data.value as? Int ?? 0
            val += tipAmount
            data.value = val
            return TransactionResult.success(withValue: data)
        })
        return true
    }
}
