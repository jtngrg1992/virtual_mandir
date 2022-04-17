//
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

protocol VirtualTempleInteracting: InteractionsPanelListener, AudioPlayerDelegate {
    var gods: [God] { get set }
    var godOnDisplay: God? { get set }
    var presenter: VirtualTemplePresenting? { get set }
    var interactionAudioDuration: TimeInterval? { get }
    func handleAartiPlaybackRequest()
}

protocol VirtualTemplePresenting: AnyObject {
    var interactor: VirtualTempleInteracting? { get set }
    var animatingBellsView:  AnimatingBellsViewing { get }
    var fallingFlowersView: FlowerFallViewing { get }
    var animatedDiyaView:  AnimatedDiyaViewing { get }
    var aartiPanelView: AartiPanelViewing { get set }
    
    func animate(interaction: MandirInteraction, forDuration duration: TimeInterval)
}

class VirtualTempleInteractor: VirtualTempleInteracting {
    var gods: [God]
    var interactionAudioDuration: TimeInterval?
    var godOnDisplay: God?
    weak var presenter: VirtualTemplePresenting?
    private var interactionAudioHandler: InteractionAudioHandling
    private var layerAnimationScheduler: VirtualMandirLayerAnimationScheduling
    private var latestInteraction: MandirInteraction?
    
    
    init(gods: [God]) {
        self.gods = gods
        godOnDisplay = gods.first
        interactionAudioHandler = InteractionAudioHandler()
        layerAnimationScheduler = VirtualmandirLayerAnimationScheduler()
        interactionAudioHandler.audioPlaybackDelegate = self
    }
}

extension VirtualTempleInteractor {
    func interactionsPanelDidRecordInteraction(_ interaction: MandirInteraction) {
        latestInteraction = interaction
        interactionAudioHandler.handleAudioForInteraction(interaction)
        
        guard let delegate = presenter else {
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
    
    func handleAartiPlaybackRequest() {
        guard let god = godOnDisplay else { return }
        presenter?.aartiPanelView.startPlayingAarti(forGod: god)
    }
}

extension VirtualTempleInteractor {
    func audioPlayerDidStartPlaying(fx: AudioFX) {
        guard
            let animationDuration = interactionAudioDuration,
            let lastInteraction = latestInteraction
        else {
            return
        }
        presenter?.animate(interaction: lastInteraction, forDuration: animationDuration)
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
