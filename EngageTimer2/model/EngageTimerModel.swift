//
//  EngageTimerModel.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import Foundation
import SwiftUI
import Combine

private var cancellable = [String: AnyCancellable]()

extension Published {
    
    init(wrappedValue value: Value, key: String) {
    
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
        cancellable[key] = projectedValue.sink { val in
            UserDefaults.standard.set(val, forKey: key)
        }
     
    }
}

class EngageTimer: ObservableObject {
    // Prepare time variables
    
    @Published(key: "prepCounterState") var prepCounterState = true
    
    // Warning time variables
    @Published(key: "warningCounter") var warningCounter = 10
    @Published(key: "warningCounterState") var warningCounterState = true
    
    // Rounds Variables
    @Published var currentRound = 1
    @Published(key: "numberOfRounds") var numberOfRounds = 5
    
    // Timer Values
    @Published(key: "time") var time = 300
    
    @Published(key: "prepareCounter") var prepareCounter = 300
    
    var engageTimerState = ["NotRunning", "Paused", "Running"]
    @Published(key: "timerState") var timerState = "NotRunning"
    @Published var totalTime = 0
    
    // Rest Values
    @Published(key: "rest") var rest = 60

    // Random Array and Random Number Placeholder used to create random sequence.
    @Published var randomArray:[Int] = []
    @Published(key: "minimumRandom") var minimumRandom = 5
    
    @Published(key: "maximumRandom") var maximumRandom = 20
    
    // Backup values
    @Published(key: "backupTime") var backupTime = 0
    @Published(key: "backupWarningCounter") var backupWarningCounter = 0
    @Published(key: "backupPrepareCounter") var backupPrepareCounter = 0
    @Published(key: "backupRest") var backupRest = 5
    
    // Random Noise state and sound type
    @Published(key: "usingRandomNoise") var usingRandomNoise = true
    @Published(key: "selectedSound") var selectedSound = 0
    @Published var noiseArray = ["Clap", "Bell", "Whistle"]

    
    func createRandomNumberArray() {
        
        // Make sure the array is blank
        randomArray = []
        // Create a variable to run through the range with
        var startingNumber = 1
        
        while startingNumber < time {
            
            let randomNumber = Int.random(in: minimumRandom...maximumRandom)
            startingNumber += randomNumber
            
            if startingNumber < time - warningCounter {
                randomArray.append(startingNumber)
            }
            
        }
        
        startingNumber = 1
        print(randomArray)
        
    }
    
    func setBackupValues() {
        backupTime = time
        backupRest = rest
        backupWarningCounter = warningCounter
        backupPrepareCounter = prepareCounter
        

    }
    

    
    func runEngageTimer() {
        
        // If prepare counter is being used, start countdown with that
        if prepCounterState == true && prepareCounter > 0 {
            prepareCounter -= 1
        // If countdown timer is done, then start timer
        } else if time > 0 && currentRound < numberOfRounds {
            
            if time == backupTime {
                playSound(sound: "boxing-bell-1", type: "wav")
            }
            
            if randomArray.contains(time) {
                playSound(sound: noiseArray[selectedSound], type: "mp3")
            }
            
            
            time -= 1
            
            if warningCounter == time && warningCounterState == true {
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
                createRandomNumberArray()
            }

            // Finished running timer, reset
        } else {
            timerState = "NotRunning"
            time = backupTime
            currentRound = 1
        }
    }
}



