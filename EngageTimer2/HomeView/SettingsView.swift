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
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack {
            Text("Edit Engage Timer Options").font(.title2).bold().padding(.top)
            
            Form {
                Section(header: Text("Timer")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Number of Rounds: \(engageTimer.numberOfRounds)")
                            Spacer()
                            Stepper("\(engageTimer.numberOfRounds)", value: $engageTimer.numberOfRounds, in: 0...50).labelsHidden()
                        }
                        
                    }
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Time:")
                            AccessoryClockFormatView(time: engageTimer.time)
                            Spacer()
                            Stepper("\(engageTimer.time)", value: $engageTimer.time, in: 0...1000, step: 10).labelsHidden()
                        }
                    }
                    VStack(alignment: .leading) {
                        
                        
                        HStack {
                            Text("Rest:")
                            AccessoryClockFormatView(time: engageTimer.rest)
                            Spacer()
                            Stepper("\(engageTimer.rest)", value: $engageTimer.rest, in: 0...500, step: 5).labelsHidden()
                        }
                        
                    }
                    
                }
                
                Section(header: Text("Random Engage Cues")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Engage Timer Cues")
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 25, style: .circular)
                                .fill(engageTimer.usingRandomNoise == true ? onColor : offColor)
                                .frame(width: 75, height: 35)
                                .overlay(
                                Circle()
                                .fill(thumbColor)
                                    .shadow(radius: 1, x: 0, y: 1)
                                    .padding(1.5)
                                    .offset(x: engageTimer.usingRandomNoise == true ? 20 : -20)
                                    .animation(Animation.easeInOut(duration: 0.3))
                                    .onTapGesture {
                                        if engageTimer.usingRandomNoise == true {
                                            engageTimer.usingRandomNoise = false
                                        } else {
                                            engageTimer.usingRandomNoise = true
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
                                Stepper("\(engageTimer.minimumRandom)", value: $engageTimer.minimumRandom, in: 0...450).labelsHidden()
                            }
                            HStack {
                                HStack {
                                    Text("Max Range:")
                                    AccessoryClockFormatView(time: engageTimer.maximumRandom)
                                }
                                
                                Spacer()
                                Stepper("\(engageTimer.maximumRandom)", value: $engageTimer.maximumRandom, in: 0...500).labelsHidden()
                            }
                            
                            VStack(alignment: .leading) {
                                
                                Text("Choose Engage Sound")
                                Picker(selection: $engageTimer.selectedSound, label: Text("Test"), content: {
                                    ForEach (0 ..< engageTimer.noiseArray.count, id: \.self) {
                                        Text(self.engageTimer.noiseArray[$0])
                                    }
                                }).pickerStyle(WheelPickerStyle()).padding(.vertical, 0)
                            
                            }
                           
                        }.disabled(engageTimer.usingRandomNoise == false)
                        .opacity(engageTimer.usingRandomNoise == true ? 1.0 : 0.5)
                        
                    }
                    
                }
                
                
                Section(header: Text("Get Ready Timer")) {
                    HStack {
                        Text("Seconds before starting timer")
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 25, style: .circular)
                            .fill(engageTimer.prepCounterState == true ? onColor : offColor)
                            .frame(width: 75, height: 35)
                        .overlay(
                            Circle()
                            .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: engageTimer.prepCounterState == true ? 20 : -20)
                                .animation(Animation.easeInOut(duration: 0.3))
                                .onTapGesture {
                                    if engageTimer.prepCounterState == true {
                                        engageTimer.prepCounterState = false
                                    } else {
                                        engageTimer.prepCounterState = true
                                    }}
                        )
                        
                    }
                    
                        HStack {
                            AccessoryClockFormatView(time: engageTimer.prepareCounter)
                            Spacer()
                            Stepper("\(engageTimer.prepareCounter)", value: $engageTimer.prepareCounter, in: 0...120).labelsHidden()
                        }
                        
                        .disabled(engageTimer.prepCounterState == false)
                        .opacity(engageTimer.prepCounterState == true ? 1.0 : 0.5)
                }
                
                Section(header: Text("Round End Warning")) {
                    HStack {
                        Text("Use Warning Sound?")
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 25, style: .circular)
                            .fill(engageTimer.warningCounterState == true ? onColor : offColor)
                            .frame(width: 75, height: 35)
                        .overlay(
                            Circle()
                            .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: engageTimer.warningCounterState == true ? 20 : -20)
                                .animation(Animation.easeInOut(duration: 0.3))
                                .onTapGesture {
                                    if engageTimer.warningCounterState == true {
                                        engageTimer.warningCounterState = false
                                    } else {
                                        engageTimer.warningCounterState = true
                                    }}
                        )
                        
                    }
                    
                        HStack {
                            AccessoryClockFormatView(time: engageTimer.warningCounter)
                            Spacer()
                            Stepper("\(engageTimer.warningCounter)", value: $engageTimer.warningCounter, in: 0...120).labelsHidden()
                        }
                        
                        .disabled(engageTimer.prepCounterState == false)
                        .opacity(engageTimer.prepCounterState == true ? 1.0 : 0.5)
                }
                
                
                
                
                
            }
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Swipe Down To Save & Exit")
                    .foregroundColor(Color("blue"))
            }
                
            
            
           
        }.onDisappear(perform: {
            engageTimer.createRandomNumberArray()
        })
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(engageTimer: EngageTimer())
    }
}
