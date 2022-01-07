//
//  SettingsView.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/5/22.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var engageTimer: EngageTimer
    
    @State var onColor = Color("blue")
    @State var offColor = Color(UIColor.systemGray)
    @State var thumbColor = Color.white
    
    
    var body: some View {
        VStack {
            Text("Edit Engage Timer Options").font(.title2).bold().padding(.top)
            
            Form {
                Section(header: Text("Timer")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Number of Rounds: \(engageTimer.numberOfRounds)")
                            Spacer()
                            Stepper("\(engageTimer.numberOfRounds)", value: $engageTimer.numberOfRounds, in: 0...25).labelsHidden()
                        }
                        
                    }
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Time:")
                            AccessoryClockFormatView(time: engageTimer.time)
                            Spacer()
                            Stepper("\(engageTimer.time)", value: $engageTimer.time, in: 0...120).labelsHidden()
                        }
                    }
                    VStack(alignment: .leading) {
                        
                        
                        HStack {
                            Text("Rest:")
                            AccessoryClockFormatView(time: engageTimer.rest)
                            Spacer()
                            Stepper("\(engageTimer.rest)", value: $engageTimer.rest, in: 0...120).labelsHidden()
                        }
                        
                    }
                    
                }
                
                Section(header: Text("Random Engage Cues")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Engage Timer Cues")
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 25, style: .circular)
                                .fill(engageTimer.usingRandomNoise == .yes ? onColor : offColor)
                                .frame(width: 75, height: 35)
                            .overlay(
                                Circle()
                                .fill(thumbColor)
                                    .shadow(radius: 1, x: 0, y: 1)
                                    .padding(1.5)
                                    .offset(x: engageTimer.usingRandomNoise == .yes ? 20 : -20)
                                    .animation(Animation.easeInOut(duration: 0.3))
                                    .onTapGesture {
                                        if engageTimer.usingRandomNoise == .yes {
                                            engageTimer.usingRandomNoise = .no
                                        } else {
                                            engageTimer.usingRandomNoise = .yes
                                        }}
                            )
                        }
                        
                        VStack(alignment: .leading) {
                            VStack {
                                HStack {
                                    AccessoryClockFormatView(time: engageTimer.minimumRandom)
                                    Text("-")
                                    AccessoryClockFormatView(time: engageTimer.maximumRandom)
                                    Text("Seconds")
                                }
                            }
                            
                            HStack {
                                HStack {
                                    Text("Min Range:")
                                    AccessoryClockFormatView(time: engageTimer.minimumRandom)
                                }
                                Spacer()
                                Stepper("\(engageTimer.minimumRandom)", value: $engageTimer.minimumRandom, in: 0...120).labelsHidden()
                            }
                            HStack {
                                HStack {
                                    Text("Max Range:")
                                    AccessoryClockFormatView(time: engageTimer.maximumRandom)
                                }
                                
                                Spacer()
                                Stepper("\(engageTimer.maximumRandom)", value: $engageTimer.maximumRandom, in: 0...120).labelsHidden()
                            }
                            
                            HStack {
                                Text("Random Noise")
                                Spacer()
                                Text("\(engageTimer.sound)").bold()
                            }
                           
                        }.disabled(engageTimer.usingRandomNoise == .no)
                        .opacity(engageTimer.usingRandomNoise == .yes ? 1.0 : 0.5)
                        
                    }
                    
                }
                
                
                Section(header: Text("Get Ready Timer")) {
                    HStack {
                        Text("Seconds before starting timer")
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 25, style: .circular)
                            .fill(engageTimer.prepCounterState == .UsingTimer ? onColor : offColor)
                            .frame(width: 75, height: 35)
                        .overlay(
                            Circle()
                            .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: engageTimer.prepCounterState == .UsingTimer ? 20 : -20)
                                .animation(Animation.easeInOut(duration: 0.3))
                                .onTapGesture {
                                    if engageTimer.prepCounterState == .UsingTimer {
                                        engageTimer.prepCounterState = .NotUsingTimer
                                    } else {
                                        engageTimer.prepCounterState = .UsingTimer
                                    }}
                        )
                        
                    }
                    
                        HStack {
                            AccessoryClockFormatView(time: engageTimer.prepareCounter)
                            Spacer()
                            Stepper("\(engageTimer.prepareCounter)", value: $engageTimer.prepareCounter, in: 0...120).labelsHidden()
                        }
                        
                        .disabled(engageTimer.prepCounterState == .NotUsingTimer)
                        .opacity(engageTimer.prepCounterState == .UsingTimer ? 1.0 : 0.5)
                }
                
                Section(header: Text("Round End Warning")) {
                    HStack {
                        Text("Use Warning Sound?")
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 25, style: .circular)
                            .fill(engageTimer.warningCounterState == .UsingTimer ? onColor : offColor)
                            .frame(width: 75, height: 35)
                        .overlay(
                            Circle()
                            .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: engageTimer.warningCounterState == .UsingTimer ? 20 : -20)
                                .animation(Animation.easeInOut(duration: 0.3))
                                .onTapGesture {
                                    if engageTimer.warningCounterState == .UsingTimer {
                                        engageTimer.warningCounterState = .NotUsingTimer
                                    } else {
                                        engageTimer.warningCounterState = .UsingTimer
                                    }}
                        )
                        
                    }
                    
                        HStack {
                            AccessoryClockFormatView(time: engageTimer.warningCounter)
                            Spacer()
                            Stepper("\(engageTimer.warningCounter)", value: $engageTimer.warningCounter, in: 0...120).labelsHidden()
                        }
                        
                        .disabled(engageTimer.prepCounterState == .NotUsingTimer)
                        .opacity(engageTimer.prepCounterState == .UsingTimer ? 1.0 : 0.5)
                }
                
                
                
                
                
            }
            Text("Swipe Down to Save").bold()
        }
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(engageTimer: EngageTimer())
    }
}
