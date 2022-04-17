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

/*
    this is the Core view representing the mandir that we see on the screen
    It has following layers displayed in chronological order:
        1. Gods Carousel - List of Gods
        2. Arch with Curtain - The red curtain arch that we see in the mandir
        3. Animated Bells - the two bells below the curtain
        4. Animated Flowers - The flowers that start falling from the top
        5. Animated Diya - The diya that lights up
        6. Interactions Panel - The various buttons that allow us to animate the layers above in this list.
        7. Aari Panel - The aarti button that handle aarti playback and pause.
 
    Each layer has been added as a subview to this. The interactor is responsible for orchestrating the interactions
    between various layers.
 */

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


// MARK: - Presenter Methods
extension VirtualTempleView {
    func animate(interaction: MandirInteraction, forDuration duration: TimeInterval) {
        interactionsPanelView.animateInteractionButton(forInteraction: interaction, forDuration: duration)
    }
}

// MARK: - AartiPanel Delegate Methods
extension VirtualTempleView {
    func aartiPanelDidRequestArtiPlayback() {
        interactor?.handleAartiPlaybackRequest()
    }
}

// MARK: - GodsCarousel Delegate Methods
extension VirtualTempleView {
    func godsCarouselDidScroll(toGod god: God) {
        interactor?.godOnDisplay = god
    }
}
