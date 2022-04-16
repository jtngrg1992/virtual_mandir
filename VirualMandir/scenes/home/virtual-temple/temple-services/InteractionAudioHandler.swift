//
//  InteractionAudioHandler.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 16/04/22.
//

import Foundation

protocol InteractionAudioHandling {
    var audioPlaybackDelegate: AudioPlayerDelegate? { get set }
    var interaction: MandirInteraction? { get }
    func handleAudioForInteraction(_ interaction: MandirInteraction)
}

class InteractionAudioHandler: InteractionAudioHandling {
    private let audioPlayer = AudioPlayer()
    weak var audioPlaybackDelegate: AudioPlayerDelegate? {
        didSet {
            audioPlayer.delegate = audioPlaybackDelegate
        }
    }
    var interaction: MandirInteraction?
    
    func handleAudioForInteraction(_ interaction: MandirInteraction) {
        self.interaction = interaction
        
        switch interaction {
        case .playShankh:
            audioPlayer.playAudio(.shankhSound)
        case .ringBell:
            audioPlayer.playAudio(.bellSound)
        default:
            break
        }
    }
}
