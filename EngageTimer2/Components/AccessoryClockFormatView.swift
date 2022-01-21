//
//  AccessoryClockFormatView.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/5/22.
//

import SwiftUI

struct AccessoryClockFormatView: View {
    
    var time: Int
    var fontSize:CGFloat = 20
    
    var body: some View {
        if time % 60 < 10 {

            Text("\(time / 60):0\(time % 60)").font(.custom("DS-Digital", size: fontSize))

        } else {
            Text("\(time / 60):\(time % 60)").font(.custom("DS-Digital", size: fontSize))
        }
    }
}

struct AccessoryClockFormatView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryClockFormatView(time: 60, fontSize: 20)
    }
}
