//
//  Oscillator.swift
//  MusicalRooms
//
//  Created by Isaac Lee Jing Zhi on 19/11/21.
//

import Foundation
import SwiftUI
import AudioKit

class OscillatorObject {
    
    var engine = AudioEngine()
    var osc = PlaygroundOscillator()
    
    init() {
        engine.output = osc
    }
    
    func start(frequency: Float = 440, _ variance: Float = 0) {
        
        osc.frequency = frequency + variance
        osc.amplitude = 0.6
        
        do {
            try engine.start()
        } catch let err {
            Log(err)
        } 
        osc.start()
    }
    
    func stop() {
        engine.stop()
    }
}
