//
//  AnimatedDiyaView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol AnimatedDiyaViewing: VirtualMandirLayer {}

class AnimatedDiyaView: View, AnimatedDiyaViewing {
    
    var isAnimating: Bool = false
    
    private var diyaView: AnimatedDiya = {
        let v = AnimatedDiya()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func setup() {
        addSubview(diyaView)
        pinBottomEdge(diyaView, considerSafeArea: true, constant: 50)
        diyaView.centerHorizontallyInContainer(20)
        isUserInteractionEnabled = false
    }
}

extension AnimatedDiyaView {
    public func layoutYourselfOutInContainer() {
        superview?.pinHorizontally(self)
        superview?.pinBottomEdge(self, considerSafeArea: true)
        constraintHeight(to: 200)
    }
    
    public func startAnimating() {
        diyaView.lightUp()
        isAnimating = true
    }
}
