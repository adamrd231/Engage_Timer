//
//  EngageTimerModel.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import Foundation
import SwiftUI

class EngageTimer: ObservableObject {
    
    @Published var prepareCounter = 5
    @Published var prepCounterState = UsingPrepCountdownTimer.UsingTimer
    
    @Published var warningCounter = 3
    @Published var warningCounterState = UsingPrepCountdownTimer.UsingTimer
    
    @Published var currentRound = 1
    @Published var numberOfRounds = 5
    
    @Published var time = 5
    @Published var timerState = EngageTimerState.NotRunning
    @Published var totalTime = 0
    
    @Published var rest = 5
    @Published var usingRandomNoise = UsingRandomNoise.yes

    @Published var minimumRandom = 1
    @Published var maximumRandom = 5
    
    @Published var backupTime = 0
    @Published var backupWarningCounter = 0
    @Published var backupPrepareCounter = 0
    @Published var backupRest = 5
    
    
    @Published var sound = "clap"
    
    
    func setBackupValues() {
        backupTime = time
        backupRest = rest
        backupWarningCounter = warningCounter
        backupPrepareCounter = prepareCounter
        

    }
    

    
    func runEngageTimer(resetValue: Int) {
        // If prepare counter is being used, start countdown with that
        if prepCounterState == .UsingTimer && prepareCounter > 0 {
            prepareCounter -= 1
        // If countdown timer is done, then start timer
        } else if time > 0 && currentRound < numberOfRounds {
            
            if time == backupTime {
                playSound(sound: "boxing-bell-1", type: "wav")
            }
            
            
            
            time -= 1
            
            if warningCounter == time && warningCounterState == .UsingTimer {
                playSound(sound: "double-hit2", type: "wav")
            }

            
        // Countdown actual timer
        } else if time == 0 && currentRound < numberOfRounds && rest > 0 {
            if rest == backupRest {
                playSound(sound: "boxing-bell-3", type: "wav")
            }
            rest -= 1
            
        // Countdown Rest Timer
        } else if time == 0 && currentRound < numberOfRounds && rest == 0 {
            if currentRound != numberOfRounds {
                time = backupTime
                rest = backupRest
                currentRound += 1
            }

            // Finished running timer, reset
        } else {
            timerState = .NotRunning
            time = resetValue
            currentRound = 1
        }
    }
}

enum EngageTimerState {
    case IsRunning
    case IsPaused
    case NotRunning
}

enum UsingPrepCountdownTimer {
    case UsingTimer
    case NotUsingTimer
}

enum UsingRandomNoise {
    case yes
    case no
    
}
