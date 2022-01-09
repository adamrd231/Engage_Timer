//
//  ContentView.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI
import CoreData

enum ActiveSheet: Identifiable {
    case none
    case settings
    case about
    
    var id: Int {
        hashValue
    }
}




struct HomeView: View {
    
    @StateObject var engageTimer: EngageTimer
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    @State var showSheet = false
    @State var activeSheet: ActiveSheet?
    
    @StateObject var storeManager: StoreManager
    
    @State var firstTimeOnScreen = true
    


    var body: some View {

        NavigationView {

            
            TabView {
            // MARK: First Screen
                VStack(spacing: 15) {
                Spacer()
                // Timer Stack View
                RoundView(currentRound: engageTimer.currentRound, numberOfRounds: engageTimer.numberOfRounds)
                ClockFormatView(time: engageTimer.time)
                    AccessoryInfoView(engageTimer: engageTimer)
                        .padding()
                        .background(Color("lightGray"))
                        .cornerRadius(15)
          
                StartButton(engageTimer: engageTimer, timer: $timer)
                ResetButton(engageTimer: engageTimer, timer: $timer)
                    
                if storeManager.purchasedRemoveAds != true {
                    
                    AdMobBanner()
                }
                Spacer()

                }.tabItem { VStack {
                    Image(systemName: "clock").foregroundColor(Color("blue"))
                        
                    Text("Engage Timer").foregroundColor(Color("blue"))
                } }
                    
                VStack {
                    
                    InAppStorePurchasesView(storeManager: storeManager)
                    
                }.tabItem { VStack {
                    Image(systemName: "creditcard").foregroundColor(Color("blue"))
                    Text("Remove Ads").foregroundColor(Color("blue"))
                } }
            }

            // MARK: Modifications on the view
            //
                
            .navigationBarItems(
                leading: Button("About Timer") {
                    self.activeSheet = .about
                }
                .foregroundColor((Color("blue"))),
                trailing:
                    Button("Settings") {
                        self.activeSheet = .settings
                        
                    }
                    .foregroundColor((Color("blue"))))
            .onAppear(perform: {
                engageTimer.totalTime = (engageTimer.time * engageTimer.numberOfRounds) + (engageTimer.rest * engageTimer.numberOfRounds)
                engageTimer.createRandomNumberArray()

            })
            .onReceive(self.timer) { _ in
                // If timer is not running
                
                if engageTimer.timerState == "NotRunning" {
                    timer.connect().cancel()
                } else {
                    // Create random number array for engage sounds
                    engageTimer.runEngageTimer()
                    
                }
                
            }
            .sheet(item: $activeSheet) { item in
                switch item {
                case .settings:
                    SettingsView(engageTimer: engageTimer)
                case .about:
                    OnboardingScreenView(doneViewing: $firstTimeOnScreen)
                default: EmptyView()
                }
               
            }
        }
        
        

        
    }

    

    
    func stopEngageTimer() {
        print("Stopping Time")
        timer.connect().cancel()
        engageTimer.timerState = "NotRunning"
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(engageTimer: EngageTimer(), storeManager: StoreManager())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
