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
    case hanumanChalisa
    case shankarArti
}

extension AudioFX {
    var fileName: String {
        switch self {
        case .shankhSound:
            return "shankh_sound"
        case .bellSound:
            return "bell_sound"
        case .hanumanChalisa:
            return "hanuman_chalisa"
        case .shankarArti:
            return "shankar_arti"
        }
    }
    
    var bundleURL: URL? {
        return Bundle.main.url(forResource: fileName, withExtension: "mp3")
    }
}
