//
//  FlowerFallView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit


protocol FlowerFallViewing: VirtualMandirLayer {
    func startAnimating()
    func stopAnimating()
}

class FlowerFallView: View, FlowerFallViewing {
    
    private let emitterLayer: FlowerEmitterLaying = FlowerEmitterLayer()
    
    override func setup() {
        self.emitterLayer.addAsSublayer(to: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emitterLayer.position = CGPoint(x: frame.width/2, y: 0)
        emitterLayer.emitterSize = CGSize(width: frame.width, height: 1)
    }
    
    public func startAnimating() {
        emitterLayer.setBirthRate(to: 2)
    }
    
    public func stopAnimating() {
        emitterLayer.setBirthRate(to: 0)
    }
    
    public func layoutYourselfOutInContainer() {
        guard let superview = superview else { return }
        superview.pinVertically(self)
        superview.pinHorizontally(self)
    }
}


