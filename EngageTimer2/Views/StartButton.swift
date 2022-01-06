//
//  StartButton.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI

struct StartButton: View {
    
    @StateObject var engageTimer: EngageTimer
    @Binding var timer: Timer.TimerPublisher
    
    
    var body: some View {
        Button(action: {
            print("\(engageTimer.time), \(engageTimer.timerState)")
            if engageTimer.timerState == .IsRunning {
                print("1")
                timer.connect().cancel()
                engageTimer.timerState = .NotRunning
            } else {
                print("2")
                // Create new timer
                timer = Timer.publish(every: 1, on: .main, in: .common)
                self.timer.connect()
                engageTimer.timerState = .IsRunning
                
                
            }
            
            
        }) {
            if engageTimer.timerState == .IsRunning {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).frame(width: 100, height: 75).foregroundColor((Color("blue")))
                    HStack {
                        Image(systemName: "pause.fill").foregroundColor(.white)
                        Text("Pause").foregroundColor(.white)
                    }
                    
                }
               
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).frame(width: 100, height: 75).foregroundColor((Color("blue")))
                    HStack {
                        Image(systemName: "play.fill").foregroundColor(.white)
                        Text("Start").foregroundColor(.white)
                    }
                   
                }
            }
            
        }
    }
}

