//
//  AccessoryInfoView.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/5/22.
//

import SwiftUI

struct AccessoryInfoView: View {
    
    @StateObject var engageTimer: EngageTimer
    
    
    var body: some View {
        HStack(spacing: 35) {
            VStack(spacing: 15) {
                VStack {
                    Text("Rest").font(.callout).fontWeight(.heavy)
                    AccessoryClockFormatView(time: engageTimer.rest)

                }
                
                VStack {
                    Text("Prepare").font(.callout).fontWeight(.heavy)
                    AccessoryClockFormatView(time: engageTimer.prepareCounter)
                }
                .opacity(engageTimer.prepCounterState == false ? 0.5 : 1.0)

                VStack {
                    Text("Warning").font(.callout).fontWeight(.heavy)
                    AccessoryClockFormatView(time: engageTimer.warningCounter)
                }.opacity(engageTimer.warningCounterState == false ? 0.5 : 1.0)
            }
            VStack(spacing: 15) {
                VStack {
                    Text("Total Time").font(.callout).fontWeight(.heavy)
                    AccessoryClockFormatView(time: engageTimer.totalTime)
                }
                VStack {
                    Text("Sound").font(.callout).fontWeight(.heavy)
                    Text(engageTimer.noiseArray[engageTimer.selectedSound]).font(.headline).fontWeight(.medium)
                }
                .opacity(engageTimer.usingRandomNoise == false ? 0.5 : 1.0)

                VStack {
                    Text("Interval").font(.callout).fontWeight(.heavy)
                    HStack {
                        AccessoryClockFormatView(time: engageTimer.minimumRandom)
                        Text("-")
                        AccessoryClockFormatView(time: engageTimer.maximumRandom)
                    }
                }
                .opacity(engageTimer.usingRandomNoise == false ? 0.5 : 1.0)
            }.onAppear(perform: {
                print("Using Random Noise: \(engageTimer.usingRandomNoise)")
            })
        }
    }
}

struct AccessoryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryInfoView(engageTimer: EngageTimer())
    }
}
