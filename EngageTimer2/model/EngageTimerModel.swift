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
    
    @Published var warningCounter = 5
    @Published var warningCounterState = UsingPrepCountdownTimer.NotUsingTimer
    
    @Published var currentRound = 1
    @Published var numberOfRounds = 5
    
    @Published var time = 3
    @Published var timerState = EngageTimerState.NotRunning
    @Published var totalTime = 0
    
    
    
    @Published var rest = 5
    @Published var usingRandomNoise = UsingRandomNoise.UsingRandomNoise

    @Published var sound = "clap"
    

    
    func runEngageTimer(resetValue: Int) {
        
        if prepCounterState == .UsingTimer && prepareCounter > 0 {
            prepareCounter -= 1
        } else if time > 0 && currentRound <= numberOfRounds {
            time -= 1
            print("Running Timer, \(time)")
        } else if time == 0 && currentRound < numberOfRounds {
            if currentRound != numberOfRounds {
                time = 3
            
                currentRound += 1
            }
            
        } else {
            timerState = .NotRunning
            time = resetValue
            currentRound = 1
        }
     print("run")
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
    case UsingRandomNoise
    case NotUsingRandomNoise
    
}
