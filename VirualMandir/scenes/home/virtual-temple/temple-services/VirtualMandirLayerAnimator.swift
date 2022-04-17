//
//  VirtualMandirLayerAnimator.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 16/04/22.
//

import Foundation


protocol VirtualMandirLayerAnimating {
    var isInProgress: Bool { get }
    var layer: VirtualMandirLayer { get }
    var animationCompletionBlock: (() -> Void)? { get set }
    func startAnimation()
}


protocol VirtualMandirLayerAnimationScheduling {
    func canSubmitAnimation(forLayer layer: VirtualMandirLayer) -> Bool
    func submitAnimation(forLayer layer: VirtualMandirLayer)
}

class VirtualMandirLayerAnimation: VirtualMandirLayerAnimating {
    var isInProgress: Bool {
        layer.isAnimating
    }
    
    var layer: VirtualMandirLayer
    
    var animationCompletionBlock: (() -> Void)?
    
    private var animationTimer: Timer?
    private var animationDuration: TimeInterval = 4
    
    init(layer: VirtualMandirLayer) {
        self.layer = layer
    }
    
    func startAnimation() {
        animationTimer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false, block: { [weak self] _ in
            guard let self = self else {
                return
            }
            if self.layer.isAnimating {
                self.layer.stopAnimating()
                self.animationCompletionBlock?()
            }
            self.animationTimer?.invalidate()
            self.animationTimer = nil
        })
        if !layer.isAnimating {
            layer.startAnimating()
        }
    }
    
}


/*
    This schedules Mandir Animations so that no conficting animations
    can be performed in parallel.
    This will also prevent any possible animation overload in events where users
    press an interaction button too many times just to play around.
 */

class VirtualmandirLayerAnimationScheduler: VirtualMandirLayerAnimationScheduling {
    private var animations: [VirtualMandirLayerAnimating] = []
    
    func canSubmitAnimation(forLayer layer: VirtualMandirLayer) -> Bool {
        /*
            can submit if:
                1. animations array do not contain any animation for the layer or
         */
        
        return getIndex(forAnimationLayer: layer) == nil
    }
    
    func submitAnimation(forLayer layer: VirtualMandirLayer) {
        var newAnimation: VirtualMandirLayerAnimating = VirtualMandirLayerAnimation(layer: layer)
        
        newAnimation.animationCompletionBlock = { [weak self] in
            guard let self = self else { return }
            // remove animation from animation queue
            guard let animationIndex = self.getIndex(forAnimationLayer: layer) else {
                return
            }
            self.animations.remove(at: animationIndex)
        }
        
        animations.append(newAnimation)
        newAnimation.startAnimation()
    }
    
    private func getIndex(forAnimationLayer layer: VirtualMandirLayer) -> Int? {
        animations.firstIndex(where: {$0.layer == layer})
    }
}

