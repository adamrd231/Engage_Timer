//
//  ResetButton.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/4/22.
//

import SwiftUI

struct ResetButton: View {
    
    @StateObject var engageTimer: EngageTimer
    
    var body: some View {
        Button(action: {
  
            print(engageTimer.timerState)
        }) {
            Text("Reset").foregroundColor((Color("blue")))
            
        }.disabled(engageTimer.timerState == .NotRunning)
        .opacity(engageTimer.timerState == .NotRunning ? 0.5 : 1.0)
    }
}

struct ResetButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetButton(engageTimer: EngageTimer())
    }
}
