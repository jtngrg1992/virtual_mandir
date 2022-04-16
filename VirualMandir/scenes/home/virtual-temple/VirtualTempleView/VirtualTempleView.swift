//
//  VirtualTempleView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit

protocol VirtualMandirLayer: View {
    var isAnimating: Bool { get }
    func layoutYourselfOutInContainer()
    func startAnimating()
    func stopAnimating()
}

extension VirtualMandirLayer {
    var isAnimating: Bool {
        false
    }
    
    func startAnimating() {}
    func stopAnimating() {}
}

protocol VirtualTempleViewing: View, VirtualTempleViewModelDelegate {
    var viewModel: VirtualTempleViewModeling? { get set }
    func getLayers() -> [VirtualMandirLayer]
}

class VirtualTempleView: View, VirtualTempleViewing {
    private lazy var godsCarousel: GodsCarouselViewing = {
        let carouselBuilderResult = GodsCarouselBuilder.build(withGods: self.viewModel?.gods ?? [])
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
    
    
    var viewModel: VirtualTempleViewModeling? {
        didSet {
            godsCarousel.setGods(viewModel?.gods ?? [])
            interactionsPanelView.setModuleDelegate(viewModel)
        }
    }
    
    convenience init(viewModel: VirtualTempleViewModeling) {
        self.init(frame: .zero)
        self.viewModel = viewModel
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
            interactionsPanelView
        ]
    }
}


extension VirtualTempleView {
    func viewModelDidRequestToAnimate(interaction: MandirInteraction, forDuration duration: TimeInterval) {
        interactionsPanelView.animateInteractionButton(forInteraction: interaction, forDuration: duration)
    }
}
