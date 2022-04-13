//
//  VirtualTempleView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit


protocol VirtualTempleViewing: View {
    var viewModel: VirtualTempleViewModeling? { get set }
    func setupLayerZero()
    func setupLayerOne()
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
    
    var viewModel: VirtualTempleViewModeling? {
        didSet {
            godsCarousel.setGods(viewModel?.gods ?? [])
        }
    }
    
    convenience init(viewModel: VirtualTempleViewModeling) {
        self.init(frame: .zero)
        self.viewModel = viewModel
    }
    
    override func setup() {
        setupLayerZero()
        setupLayerOne()
    }
    
    func setupLayerZero() {
        addSubview(godsCarousel)
        pinVertically(godsCarousel)
        pinHorizontally(godsCarousel)
    }
    
    func setupLayerOne() {
        addSubview(curtainArchView)
        pinTopEdge(curtainArchView, considerSafeArea: false)
        pinHorizontally(curtainArchView)
    }
}
