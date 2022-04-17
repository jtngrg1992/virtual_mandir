//
//  Oscillator.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 14/04/22.
//

import UIKit

protocol OscillatorViewing: View, CAAnimationDelegate {
    func startOscillating()
    func stopOscillating()
}

/*
    this class basically serializes 3 animations to make it look like
    that the view is oscillating between two points.
    this is not physically acurate yet but this should do for this mock project
 */

class OscillatorView: View, OscillatorViewing {
    private let timeTakenForOneOscillation: CFTimeInterval = 2
    private let animationAngle = CGFloat.pi/15
    private var shouldRepeatOscillation: Bool = true
    private var isOscillating: Bool = false
    
    
    private var animationTemplate: CABasicAnimation {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation")
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        return animation
    }
    
    private lazy var animation1: CABasicAnimation = {
        let oscillation = animationTemplate
        oscillation.fromValue = 0
        oscillation.duration = timeTakenForOneOscillation/4
        oscillation.toValue = -animationAngle
        return oscillation
    }()
    
    private lazy var animation2: CABasicAnimation = {
        let oscillation = animationTemplate
        oscillation.fromValue = -animationAngle
        oscillation.duration = timeTakenForOneOscillation/2
        oscillation.toValue = animationAngle
        return oscillation
    }()
    
    private lazy var animation3: CABasicAnimation = {
        let oscillation = animationTemplate
        oscillation.fromValue = animationAngle
        oscillation.duration = timeTakenForOneOscillation/2
        oscillation.toValue = -animationAngle
        return oscillation
    }()
    
    private lazy var resetAnimation: CABasicAnimation = {
        let resetOscillation = animationTemplate
        resetOscillation.delegate = nil
        resetOscillation.toValue = 0
        resetOscillation.duration = timeTakenForOneOscillation/2
        return resetOscillation
    }()
    
    private var animationStack: [CABasicAnimation] = []
    
    override func setup() {
        animationStack = [animation3, animation2, animation1]
    }
    
    public func startOscillating() {
        guard animationStack.count > 0 else { return }
        guard !isOscillating else { return }
        
        setAnchorPoint(CGPoint(x: 0, y: 0))
        layer.add(animationStack.last!, forKey: nil)
        isOscillating = true
    }
    
    public func stopOscillating() {
        shouldRepeatOscillation = false
    }
}

extension OscillatorView {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard shouldRepeatOscillation && isOscillating else {
            layer.add(resetAnimation, forKey: nil)
            isOscillating = false
            shouldRepeatOscillation = true
            animationStack = [animation3, animation2, animation1]
            return
        }
        guard let animationThatEnded = animationStack.last else {
            return
        }
        
        // move this to the bottom of the stack
        if animationThatEnded != animation1 {
            // get rid of it since we won't play it anymore
            animationStack.insert(animationThatEnded, at: 0)
        }
        
        animationStack.removeLast()
        
        guard let animationToStart = animationStack.last else {
            return
        }
        layer.add(animationToStart, forKey: nil)
        
    }
}
