//
//  EngageTimer2App.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI

@main
struct EngageTimer2App: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var engageTimer = EngageTimer()

    var body: some Scene {
        WindowGroup {
            HomeView(engageTimer: engageTimer)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
