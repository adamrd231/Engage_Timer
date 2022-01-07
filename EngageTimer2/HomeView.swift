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
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var engageTimer: EngageTimer
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    @State var showSheet = false
    @State var activeSheet: ActiveSheet?
    
    
    

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                
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
                        Spacer()
                            
                        ZStack {
                            Rectangle().foregroundColor(Color("lightGray"))
                            Text("Admob")
                        }.frame(height: 75)

                    }.tabItem { VStack {
                        Image(systemName: "clock")
                            
                        Text("Engage Timer")
                    } }
                        
                    VStack {
                        
                        Text("Second Page")
                    }.tabItem { VStack {
                        Image(systemName: "creditcard")
                        Text("Remove Ads")
                    } }
                }

                // MARK: Modifications on the view
                //
                .navigationBarItems(
                    leading: Button("About Timer") {
                        self.activeSheet = .about
        
                        
                        
                    }.foregroundColor((Color("blue"))),
                    trailing:
                        Button("Settings") {
                            self.activeSheet = .settings
                            
                        }.foregroundColor((Color("blue"))))
                        .onAppear(perform: {
                            engageTimer.totalTime = (engageTimer.time * engageTimer.numberOfRounds) + (engageTimer.rest * engageTimer.numberOfRounds)
                })
                .onReceive(self.timer) { _ in
                    if engageTimer.timerState == .NotRunning {
                        
                        timer.connect().cancel()
                    } else {
                        engageTimer.runEngageTimer(resetValue: 3)
                    }
                    
                }
                    .sheet(item: $activeSheet) { item in
                        switch item {
                        case .settings:
                            SettingsView(engageTimer: engageTimer)
                        case .about:
                            OnboardingScreenView()
                        default: EmptyView()
                        }
                       
                    }
                    
            }
            
        }
        
    }

    

    
    func stopEngageTimer() {
        print("Stopping Time")
        timer.connect().cancel()
        engageTimer.timerState = .NotRunning
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
        HomeView(engageTimer: EngageTimer()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
