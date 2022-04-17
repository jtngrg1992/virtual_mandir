//
//  AnimatedFlame.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol AnimatedFlaming: UIImageView {
    var interactor: AnimatedFlameInteracting? { get set }
}

class AnimatedFlame: UIImageView, AnimatedFlaming {
    
    public var interactor: AnimatedFlameInteracting? {
        didSet {
            guard let flameAssets = interactor?.flameFrames else { return }
            animationImages = flameAssets
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(CustomUIKitError.initCoderNotImplemented.localizedDescription)
    }
    
    
    private func setup() {
        animationDuration = 2
        contentMode = .scaleAspectFit
    }
}
