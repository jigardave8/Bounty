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
    
    // Live Mission Data Tracker
    var liveO: Int = 0
    var liveX: Int = 0
    
    var vaultReserve: Int = 100

    
    // Core database references isolated from SwiftUI state tracking
    @ObservationIgnored private var db = Firestore.firestore()
    @ObservationIgnored private var rtdb = Database.database(url: "https://bounty-d54d6-default-rtdb.europe-west1.firebasedatabase.app").reference()
      
      @ObservationIgnored private var pulseHandle: DatabaseHandle?
    init() {
        // Fallback offline mock structure while awaiting first cloud sync
        self.activeBounties = mockBounties
        fetchGridBounties()
    }
    
    // MARK: - Firestore: Low-Frequency Grid Reads
    func fetchGridBounties() {
        // Listens to the 'bounties' collection. Filtered down to save document read costs.
        db.collection("bounties").whereField("isActive", isEqualTo: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self, let docs = snapshot?.documents else {
                    print("Grid Sync Failed: \(error?.localizedDescription ?? "Unknown")")
                    return
                }
                
                var fetched = [Bounty]()
                for doc in docs {
                    let data = doc.data()
                    let b = Bounty(
                        id: doc.documentID, // Pure String sync for Document Reference
                        title: data["title"] as? String ?? "UNKNOWN DIRTY JOB",
                        target: data["target"] as? String ?? "CITY LIMITS",
                        poolO: data["poolO"] as? Int ?? 0,
                        poolX: data["poolX"] as? Int ?? 0,
                        ytVideoId: data["ytVideoId"] as? String ?? ""
                    )
                    fetched.append(b)
                }
                
                // Safe UI Update
                Task { @MainActor in
                    if !fetched.isEmpty {
                        self.activeBounties = fetched
                    }
                }
            }
    }
    
    // MARK: - RTDB: Live Connection Lifecycle (The Cockpit Sync)
    func tuneIntoThermalFrequency(bountyId: String) {
        let path = "missions/\(bountyId)"
        let missionRef = rtdb.child(path)
        
        // Starts ultra-low latency listening channel
        pulseHandle = missionRef.observe(.value) { [weak self] snapshot in
            guard let self = self, let dict = snapshot.value as?[String: Any] else { return }
            
            Task { @MainActor in
                withAnimation(Theme.tacticalSpring) {
                    self.liveO = dict["poolO"] as? Int ?? 0
                    self.liveX = dict["poolX"] as? Int ?? 0
                }
            }
        }
    }
    
    func dropThermalFrequency(bountyId: String) {
        if let handle = pulseHandle {
            rtdb.child("missions/\(bountyId)").removeObserver(withHandle: handle)
            self.pulseHandle = nil
            Task { @MainActor in
                self.liveO = 0
                self.liveX = 0
            }
        }
    }
    
    // MARK: - RTDB: High-Frequency Tipping "Pulse" Dispatch
    func dispatchThermalPulse(bountyId: String, isHero: Bool, tipAmount: Int = 10) -> Bool {
        guard vaultReserve >= tipAmount else {
            print("Action Denied: Insufficient Reserve Funds.")
            return false
        }
        
        // Burn the local funds
        Task { @MainActor in self.vaultReserve -= tipAmount }
        
        // RTDB Path
        let path = "missions/\(bountyId)/\(isHero ? "poolO" : "poolX")"
        let poolRef = rtdb.child(path)
        
        poolRef.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            var value = currentData.value as? Int ?? 0
            value += tipAmount
            currentData.value = value
            return TransactionResult.success(withValue: currentData)
        }) { error, committed, snapshot in
            if let error = error {
                print("Thermal Pulse Jammed: \(error.localizedDescription)")
            } else if committed {
                print("Grid Uplink: \(path) advanced by +\(tipAmount).")
            }
        }
        
        return true
    }
    
}
