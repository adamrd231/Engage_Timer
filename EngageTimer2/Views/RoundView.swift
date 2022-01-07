//
//  RoundView.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/5/22.
//

import SwiftUI

struct RoundView: View {
    
    var currentRound: Int
    var numberOfRounds: Int
    var fontSize: CGFloat = 50
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Round").font(.title3).fontWeight(.black).foregroundColor(Color("blue"))
            HStack {
                Text("\(currentRound)").font(.custom("DS-Digital", size: fontSize))
                Text("OF")
                Text("\(numberOfRounds)").font(.custom("DS-Digital", size: fontSize))
            }
            
            
        }
    }
}

struct RoundView_Previews: PreviewProvider {
    static var previews: some View {
        RoundView(currentRound: 1, numberOfRounds: 5)
    }
}
