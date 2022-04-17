//
//  ArtiPanelInteractor.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 17/04/22.
//

import Foundation


protocol AartiPanelListener: AnyObject {
    func aartiPanelDidRequestArtiPlayback()
}

protocol AartiPanelInteracting: AudioPlayerDelegate {
    var presenter: AartiPanelPresenting? { get set }
    var listener: AartiPanelListener? { get set }
    func playAarti(forGod god: God)
    func pauseAarti()
    func aartiButtonTapped()
}


enum AartiPlaybackState {
    case stopped, playing, paused
}

class AartiPanelInteractor: AartiPanelInteracting {
    
    weak var presenter: AartiPanelPresenting?
    weak var listener: AartiPanelListener?
    
    private var isPlayingAarti: Bool = false
    private let audioPlayer = AudioPlayer()
    private var aartiPlaybackState: AartiPlaybackState = .stopped
    
    init() {
        audioPlayer.delegate = self
    }
    
    
    func aartiButtonTapped() {
        switch aartiPlaybackState {
        case .stopped:
            listener?.aartiPanelDidRequestArtiPlayback()
        case .playing:
            pauseAarti()
        case .paused:
            resumeAarti()
        }
    }
    
    func playAarti(forGod god: God) {
        guard let artiFile = god.artiMusic else{
            return
        }
        audioPlayer.playAudio(artiFile)
        presenter?.aartiButton.switchToPause()
    }
    
    func resumeAarti() {
        audioPlayer.resumeAudio()
        presenter?.aartiButton.switchToPause()
        aartiPlaybackState = .playing
    }
    
    func pauseAarti() {
        audioPlayer.pauseAudio()
        presenter?.aartiButton.switchToPlay()
        isPlayingAarti = false
        aartiPlaybackState = .paused
    }
}

// MARK: - AudioPlayer Delegate
extension AartiPanelInteractor {
    func audioPlayerDidStartPlaying(fx: AudioFX) {
        isPlayingAarti = true
        aartiPlaybackState = .playing
    }
    
    func audioPlayerDidFinishPlaying(_ audioPlayer: AudioPlayer) {
        aartiPlaybackState = .stopped
        presenter?.aartiButton.switchToPlay()
        presenter?.aartiButton.updateAartiProgress(to: 0)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeProgressTo progress: Double) {
        presenter?.aartiButton.updateAartiProgress(to: progress)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didEncounterError error: AudioPlayerError) {
        aartiPlaybackState = .stopped
    }
}
