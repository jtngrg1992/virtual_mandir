//
//  AnimatingBellsView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit


protocol AnimatingBellsViewing: VirtualMandirLayer {
    func startAnimating()
    func stopAnimating()
}

class AnimatingBellsView: View, AnimatingBellsViewing {
    
    private let leftBell: AnimatedBell = AnimatedBell()
    private let rightBell: AnimatedBell = AnimatedBell()
    
    override func setup() {
        isUserInteractionEnabled = false
        
        leftBell.translatesAutoresizingMaskIntoConstraints = false
        rightBell.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftBell)
        addSubview(rightBell)
        
        [leftBell, rightBell].forEach {
            pinTopEdge($0, considerSafeArea: false)
            pinBottomEdge($0, considerSafeArea: false)
            if $0 == leftBell {
                pinLeadingEdge(leftBell, constant: -50)
            } else {
                pinTrailingEdge(rightBell, constant: 50)
            }
        }
    }
}

extension AnimatingBellsView {
    public func startAnimating() {
        leftBell.startOscillating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.rightBell.startOscillating()
        }
    }
    
    public func stopAnimating() {
        leftBell.stopOscillating()
        rightBell.stopOscillating()
    }
    
    public func layoutYourselfOutInContainer() {
        guard let superview = superview else {
            return
        }
        superview.pinHorizontally(self)
        superview.pinTopEdge(self, considerSafeArea: true, constant: -110)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.leftBell.startOscillating()
//            
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
//            self.rightBell.startOscillating()
//        }
    }
}
