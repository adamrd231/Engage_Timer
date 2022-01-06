//
//  ContentView.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var engageTimer: EngageTimer
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    @State var showSheet = false
    
    @State var sheetSelection = 1
    

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    VStack {
                        RoundView(currentRound: engageTimer.currentRound, numberOfRounds: engageTimer.numberOfRounds)
                        
                            
                        ClockFormatView(time: engageTimer.time)
                        
                        VStack(spacing: 25) {
                            StartButton(engageTimer: engageTimer, timer: $timer)
                            ResetButton(engageTimer: engageTimer)
                        }.padding()
                        
                        
                    }.frame(width: geo.size.width, height: geo.size.height * 0.61, alignment: .center)
                   
                    
                    AccessoryInfoView(engageTimer: engageTimer).frame(width: geo.size.width, height: geo.size.height * 0.3, alignment: .top)
                        
                    Spacer()
                    ZStack {
                        Rectangle()
                        Text("Admob").foregroundColor(.white)
                    }.frame(width: geo.size.width, height: geo.size.height * 0.09, alignment: .center)
                    
                }

                // MARK: Modifications on the view
                //
                .frame(width: geo.size.width, height: geo.size.height)
                .navigationTitle(Text("EngageTimer"))
                .navigationBarItems(
                    leading: Button("About Timer") {
                        self.sheetSelection = 2
                        showSheet.toggle()
                    }.foregroundColor((Color("blue"))),
                    trailing:
                        Button("Settings") {
                            self.sheetSelection = 1
                            showSheet.toggle()
                }.foregroundColor((Color("blue"))))
                .onAppear(perform: {
                    engageTimer.totalTime = engageTimer.time * engageTimer.numberOfRounds
                })
                .onReceive(self.timer) { _ in
                    if engageTimer.timerState == .NotRunning {
                        timer.connect().cancel()
                    } else {
                        engageTimer.runEngageTimer(resetValue: 3)
                    }
                    
                }
                .sheet(isPresented: $showSheet) {
                    if self.sheetSelection == 1 {
                        SettingsView()
                    } else {
                        AboutEngageTimerView()
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
