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
            
            switch engageTimer.timerState {
            case .NotRunning:
                playSound(sound: "start-button", type: "wav")
                // Create new timer
                timer = Timer.publish(every: 1, on: .main, in: .common)
                engageTimer.setBackupValues()
                self.timer.connect()
                engageTimer.timerState = .IsRunning
                
            case .IsPaused:
                playSound(sound: "pause", type: "wav")
                // Create new timer
                timer = Timer.publish(every: 1, on: .main, in: .common)
                self.timer.connect()
                engageTimer.timerState = .IsRunning
                
            case .IsRunning:
                playSound(sound: "pause", type: "wav")
                timer.connect().cancel()
                engageTimer.timerState = .IsPaused
                
            }
            
        }) {
            
            
            switch engageTimer.timerState {
            case .IsRunning:
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).frame(width: 150, height: 75).foregroundColor((Color("blue")))
                    HStack {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                        Text("Pause").foregroundColor(.white)
                    }
                }
                
            case .NotRunning:
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).frame(width: 150, height: 75).foregroundColor((Color("blue")))
                    HStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                        Text("Start").foregroundColor(.white)
                    }
                }
                
            case .IsPaused:
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).frame(width: 150, height: 75).foregroundColor((Color("blue")))
                    HStack {
                        Image(systemName: "play.fill").foregroundColor(.white)
                        Text("Resume").foregroundColor(.white)
                    }
                }
            }
        }
    }
}

