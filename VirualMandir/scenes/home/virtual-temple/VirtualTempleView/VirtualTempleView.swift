//
//  VirtualTempleView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit

protocol VirtualTempleViewing: View, VirtualTemplePresenting, AartiPanelListener, GodsCarouselListener {
    func getLayers() -> [VirtualMandirLayer]
}

class VirtualTempleView: View, VirtualTempleViewing {
    private lazy var godsCarousel: GodsCarouselViewing = {
        let carouselBuilderResult = GodsCarouselBuilder.build(withGods: self.interactor?.gods ?? [], andListener: self)
        carouselBuilderResult.translatesAutoresizingMaskIntoConstraints = false
        return carouselBuilderResult
    }()
    
    private var curtainArchView: CurtainArchViewing = {
        let view: CurtainArchViewing = CurtainArchView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animatingBellsView: AnimatingBellsViewing = {
        let view: AnimatingBellsViewing = AnimatingBellsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var fallingFlowersView: FlowerFallViewing = {
        let view: FlowerFallViewing = FlowerFallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animatedDiyaView: AnimatedDiyaViewing = {
        let view = AnimatedDiyaView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var interactionsPanelView: InteractionsPanelViewing = {
        let view = InteractionsPanelBuilder.build(withInteractions: [.playShankh,.ringBell,.offerFlowers, .lightDiya])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var aartiPanelView: AartiPanelViewing = {
        let view: AartiPanelViewing = AartiPanelBuilder.build(withListener: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var interactor: VirtualTempleInteracting? {
        didSet {
            godsCarousel.setGods(interactor?.gods ?? [])
            interactionsPanelView.setListener(interactor)
        }
    }
    
    override func setup() {
        getLayers().forEach {
            addSubview($0)
            $0.layoutYourselfOutInContainer()
        }
    }
    
    internal func getLayers() -> [VirtualMandirLayer] {
        return [
            godsCarousel,
            animatingBellsView,
            curtainArchView,
            fallingFlowersView,
            animatedDiyaView,
            interactionsPanelView,
            aartiPanelView
        ]
    }
}


extension VirtualTempleView {
    func animate(interaction: MandirInteraction, forDuration duration: TimeInterval) {
        interactionsPanelView.animateInteractionButton(forInteraction: interaction, forDuration: duration)
    }
}

extension VirtualTempleView {
    func aartiPanelDidRequestArtiPlayback() {
        interactor?.handleAartiPlaybackRequest()
    }
}

extension VirtualTempleView {
    func godsCarouselDidScroll(toGod god: God) {
        interactor?.godOnDisplay = god
    }
}
