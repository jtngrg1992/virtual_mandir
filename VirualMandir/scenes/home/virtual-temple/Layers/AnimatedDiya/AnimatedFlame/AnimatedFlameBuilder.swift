//
//  AnimatedFlameBuilder.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import Foundation

class AnimatedFlameBuilder {
    static func build(withAssetName assetName: String, frameRate: Int) -> AnimatedFlaming {
        let interactor: AnimatedFlameInteracting = AnimatedFlameInteractor(flameAssetName: assetName, flameFrameRate: frameRate, separator: "_")
        let view: AnimatedFlaming = AnimatedFlame(frame: .zero)
        view.interactor = interactor
        return view
    }
}
