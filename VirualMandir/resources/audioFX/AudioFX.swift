//
//  AudioFX.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 16/04/22.
//

import Foundation


enum AudioFX {
    case shankhSound
    case bellSound
}

extension AudioFX {
    var fileName: String {
        switch self {
        case .shankhSound:
            return "shankh_sound"
        case .bellSound:
            return "bell_sound"
        }
    }
    
    var bundleURL: URL? {
        return Bundle.main.url(forResource: fileName, withExtension: "mp3")
    }
}
