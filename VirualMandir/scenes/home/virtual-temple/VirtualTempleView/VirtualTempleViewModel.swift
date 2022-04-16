//
//  VirtualTempleViewModel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

protocol VirtualTempleViewModeling: InteractionsPanelModuleDelegate, AudioPlayerDelegate {
    var gods: [God] { get set }
    var delegate: VirtualTempleViewModelDelegate? { get set }
    var interactionAudioDuration: TimeInterval? { get }
}

protocol VirtualTempleViewModelDelegate: AnyObject {
    var animatingBellsView:  AnimatingBellsViewing { get }
    var fallingFlowersView: FlowerFallViewing { get }
    var animatedDiyaView:  AnimatedDiyaViewing { get }
    
    func viewModelDidRequestToAnimate(interaction: MandirInteraction, forDuration duration: TimeInterval)
}

class VirtualTempleViewModel: VirtualTempleViewModeling {
    var gods: [God]
    var interactionAudioDuration: TimeInterval?
    weak var delegate: VirtualTempleViewModelDelegate?
    private var interactionAudioHandler: InteractionAudioHandling
    private var layerAnimationScheduler: VirtualMandirLayerAnimationScheduling
    private var latestInteraction: MandirInteraction?
    
    
    init(gods: [God]) {
        self.gods = gods
        interactionAudioHandler = InteractionAudioHandler()
        layerAnimationScheduler = VirtualmandirLayerAnimationScheduler()
        interactionAudioHandler.audioPlaybackDelegate = self
    }
}

extension VirtualTempleViewModel {
    func interactionsPanelDidRecordInteraction(_ interaction: MandirInteraction) {
        latestInteraction = interaction
        interactionAudioHandler.handleAudioForInteraction(interaction)
        
        guard let delegate = delegate else {
            return
        }
        
        var layerToAnimate: VirtualMandirLayer?
        
        switch interaction {
        case .lightDiya:
            layerToAnimate = delegate.animatedDiyaView
        case .offerFlowers:
            layerToAnimate = delegate.fallingFlowersView
        case .ringBell:
            layerToAnimate = delegate.animatingBellsView
        default:
            break
        }
        
        guard layerToAnimate != nil else { return }
        
        if layerAnimationScheduler.canSubmitAnimation(forLayer: layerToAnimate!) {
            layerAnimationScheduler.submitAnimation(forLayer: layerToAnimate!)
        }
    }
}

extension VirtualTempleViewModel {
    func audioPlayerDidStartPlaying(fx: AudioFX) {
        guard
            let animationDuration = interactionAudioDuration,
            let lastInteraction = latestInteraction
        else {
            return
        }
        delegate?.viewModelDidRequestToAnimate(interaction: lastInteraction, forDuration: animationDuration)
    }
    
    func audioPlayerDidFinishPlaying(_ audioPlayer: AudioPlayer) {
        interactionAudioDuration = nil
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didEncounterError error: AudioPlayerError) {
        
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didReportDuration duration: TimeInterval) {
        interactionAudioDuration = duration
    }
}
