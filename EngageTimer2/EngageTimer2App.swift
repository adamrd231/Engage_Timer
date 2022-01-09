//
//  EngageTimer2App.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI
import AppTrackingTransparency
import StoreKit
import GoogleMobileAds

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
                    
                    if storeManager.showedAdvertising == false && storeManager.purchasedRemoveAds == false {
                        storeManager.showedAdvertising = true
                        requestIDFA()
                        print(storeManager.showedAdvertising)
                        
                    }
                    
                })

        }
    }
    
    // Interstitial object for Google Ad Mobs to play video advertising
    @State var interstitial: GADInterstitialAd?
    
    #if targetEnvironment(simulator)
        // Test Ad
        var googleBannerInterstitialAdID = "ca-app-pub-3940256099942544/1033173712"
    #else
        // Real Ad
        var googleBannerInterstitialAdID = "ca-app-pub-4186253562269967/5998934622"
    #endif
    
    
    // App Tracking Transparency - Request permission and play ads on open only
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.
 
        let request = GADRequest()
            GADInterstitialAd.load(
                withAdUnitID: googleBannerInterstitialAdID,
                request: request,
                completionHandler: { [self] ad, error in
                    // Check if there is an error
                    if let error = error {
                        return
                    }
                    // If no errors, create an ad and serve it
                    interstitial = ad
                    let root = UIApplication.shared.windows.first?.rootViewController
                    self.interstitial!.present(fromRootViewController: root!)

                    }
                )

      })
    }
    
    
}
