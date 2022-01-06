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
                    Text("Rest").font(.callout).fontWeight(.black)
                    AccessoryClockFormatView(time: engageTimer.rest)
//                    Text("\(engageTimer.rest)")
//                        .font(.headline)
                }
                VStack {
                    Text("Prepare").font(.callout).fontWeight(.black)
                    AccessoryClockFormatView(time: engageTimer.prepareCounter)
                }

                VStack {
                    Text("Warning").font(.callout).fontWeight(.black)
                    AccessoryClockFormatView(time: engageTimer.warningCounter)
                }
            }
            VStack(spacing: 15) {
                VStack {
                    Text("Total Time").font(.callout).fontWeight(.black)
                    AccessoryClockFormatView(time: engageTimer.totalTime)
                }
                VStack {
                    Text("Sound").font(.callout).fontWeight(.black)
                    Text(engageTimer.sound).font(.headline).fontWeight(.medium)
                }

                VStack {
                    Text("Interval").font(.callout).fontWeight(.black)
                    Text("3-7s").font(.headline).fontWeight(.medium)
                }
            }
        }
    }
}

struct AccessoryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryInfoView(engageTimer: EngageTimer())
    }
}
