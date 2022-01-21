//
//  ClockFormatView.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/5/22.
//

import SwiftUI

struct ClockFormatView: View {
    
    var time: Int
    var fontSize:CGFloat = 100
    
    
    var body: some View {
 
        if time % 60 < 10 {

            VStack {
                Text("Time").font(.title3).fontWeight(.black).foregroundColor(Color("blue"))

                HStack(alignment: .bottom) {
                    Text("\(time / 60)").font(.custom("DS-Digital", size: fontSize))
                    Text(":").font(.custom("DS-Digital", size: fontSize))
                    Text("0\(time % 60)").font(.custom("DS-Digital", size: fontSize))
                }
            }
                

        } else {
            VStack {
                Text("Time").font(.title3).fontWeight(.black).foregroundColor(Color("blue"))
                HStack(alignment: .bottom) {
                    Text("\(time / 60)").font(.custom("DS-Digital", size: fontSize))
                    Text(":").font(.custom("DS-Digital", size: fontSize))
                    Text("\(time % 60)").font(.custom("DS-Digital", size: fontSize))
                }
            }
        }
    }
}

struct ClockFormatView_Previews: PreviewProvider {
    static var previews: some View {
        ClockFormatView(time: 60)
    }
}
