//
//  ResetButton.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI

struct ResetButton: View {
    
    @StateObject var engageTimer: EngageTimer
    @Binding var timer: Timer.TimerPublisher
    
    func resetValues() {
        engageTimer.time = engageTimer.backupTime
        engageTimer.rest = engageTimer.backupRest
        engageTimer.prepareCounter = engageTimer.backupPrepareCounter
        engageTimer.warningCounter = engageTimer.backupWarningCounter
        engageTimer.currentRound = 1
    }
    
    var body: some View {
        Button(action: {
            playSound(sound: "stop-button", type: "wav")
            timer.connect().cancel()
            engageTimer.timerState = "NotRunning"
            resetValues()
            print(engageTimer.timerState)
        }) {
            Text("Reset").foregroundColor((Color("blue")))
            
        }.disabled(engageTimer.timerState == "NotRunning")
        .opacity(engageTimer.timerState == "NotRunning" ? 0.5 : 1.0)
    }
}

