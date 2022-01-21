//
//  HomeViewModel.swift
//  EngageTimer2
//
//  Created by Adam Reed on 1/20/22.
//

import Foundation


class HomeViewModel: ObservableObject {
    
    @Published var engageTimer = EngageTimer()
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    
    init() {
        
    }
    
}
