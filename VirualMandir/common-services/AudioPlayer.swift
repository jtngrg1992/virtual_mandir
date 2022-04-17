//
//  AudioPlayer.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 16/04/22.
//

import AVFoundation

protocol AudioPlayerDelegate: AnyObject {
    func audioPlayer(_ audioPlayer: AudioPlayer, didEncounterError error: AudioPlayerError)
    func audioPlayerDidFinishPlaying(_ audioPlayer: AudioPlayer)
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeProgressTo progress: Double)
    func audioPlayer(_ audioPlayer: AudioPlayer, didReportDuration duration: TimeInterval)
    func audioPlayerDidStartPlaying(fx: AudioFX)
}

extension AudioPlayerDelegate {
    func audioPlayerDidStartPlaying(fx: AudioFX) {}
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeProgressTo progress: Double) {}
    func audioPlayerDidFinishPlaying(_ audioPlayer: AudioPlayer){}
    func audioPlayer(_ audioPlayer: AudioPlayer, didReportDuration duration: TimeInterval){}
}

protocol AudioPlaying: NSObject, AVAudioPlayerDelegate {
    var currentlyPlayingAudio: AudioFX? { get }
    var delegate: AudioPlayerDelegate? { get set }
    var isPlaying: Bool { get }
    func playAudio(_ audio: AudioFX)
    func pauseAudio()
    func resumeAudio()
    func stopAudio(_ audio: AudioFX)
}

enum AudioPlayerError: Error {
    case audioFileNotFound
    case failedToConfigureSession
    case playerInitFailure
    case unableToStopPlayback
    case decodingFailed
}

extension AudioPlayerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .audioFileNotFound:
            return Strings.noAudioFile.getLocalizedString(forLanguage: .hindi)
        case .failedToConfigureSession, .playerInitFailure, .unableToStopPlayback, .decodingFailed:
            return Strings.technicalFailure.getLocalizedString(forLanguage: .hindi)
        }
    }
}

class AudioPlayer: NSObject, AudioPlaying {
    private let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    private var player: AVAudioPlayer?
    private var soundDuration: TimeInterval = 0
    private var periodicTimeObserver: Timer?
    
    weak var delegate: AudioPlayerDelegate?
    var currentlyPlayingAudio: AudioFX?
    var isPlaying: Bool { player?.isPlaying ?? false }
    
    private func configureSession() throws {
        try audioSession.setCategory(.playback, options: .duckOthers)
        try audioSession.setActive(true)
    }
    
    func playAudio(_ audio: AudioFX) {
        guard !isPlaying else { return }
        guard let fileURL = audio.bundleURL else {
            delegate?.audioPlayer(self, didEncounterError: .audioFileNotFound)
            return
        }
        do {
            try configureSession()
        }catch {
            delegate?.audioPlayer(self, didEncounterError: .failedToConfigureSession)
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: fileURL, fileTypeHint: AVFileType.mp3.rawValue)
            soundDuration = player?.duration ?? 0
            delegate?.audioPlayer(self, didReportDuration: soundDuration)
            periodicTimeObserver = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
                guard
                    let totalSoundDuration = self?.soundDuration,
                    let currentTime = self?.player?.currentTime
                else {
                    return
                }
                
                let progress: Double = currentTime/totalSoundDuration
                self?.delegate?.audioPlayer(self!, didChangeProgressTo: progress)
            })
            player?.delegate = self
            player?.setVolume(1, fadeDuration: 0.5)
            player?.play()
            currentlyPlayingAudio = audio
            delegate?.audioPlayerDidStartPlaying(fx: audio)
        }catch {
            delegate?.audioPlayer(self, didEncounterError: .playerInitFailure)
        }
    }
    
    
    func pauseAudio() {
        player?.pause()
    }
    
    func resumeAudio() {
        player?.play()
    }
    
    func stopAudio(_ audio: AudioFX) {
        guard let player = player, isPlaying else {
            return
        }
        
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            delegate?.audioPlayer(self, didEncounterError: .unableToStopPlayback)
        }
        
        player.stop()
    }
    
    private func invalidateTimeObserver() {
        periodicTimeObserver?.invalidate()
        periodicTimeObserver = nil
    }
}

extension AudioPlayer {
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        delegate?.audioPlayer(self, didEncounterError: .decodingFailed)
        invalidateTimeObserver()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.audioPlayerDidFinishPlaying(self)
        invalidateTimeObserver()
    }
}
