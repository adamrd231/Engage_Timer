//
//  EngageTimer2App.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI
import AppTrackingTransparency
import StoreKit

@main
struct EngageTimer2App: App {
    let persistenceController = PersistenceController.shared
    
    // Data Model
    @StateObject var engageTimer = EngageTimer()
    
    // StoreManager object to make in-app purchases
    @StateObject var storeManager = StoreManager()
    
    // Advertising Product Id's
    var productIds = ["design.rdconcepts.boxing.removeads"]

    var body: some Scene {
        WindowGroup {
            HomeView(engageTimer: engageTimer, storeManager: storeManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: {
                    
                    if storeManager.myProducts.isEmpty {
                        SKPaymentQueue.default().add(storeManager)
                        storeManager.getProducts(productIDs: productIds)
                    }
                    
                })
        }
    }
}
