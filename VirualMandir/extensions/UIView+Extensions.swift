//
//  UIView+Extensions.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit


extension UIView {
    func pinHorizontally(_ view: UIView) {
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func pinVertically(_ view: UIView) {
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func pinTopEdge(_ view: UIView, considerSafeArea: Bool) {
        (considerSafeArea ? safeAreaLayoutGuide.topAnchor : topAnchor)
            .constraint(equalTo: view.topAnchor)
            .isActive = true
    }
    
    func pinBottomEdge(_ view: UIView, considerSafeArea: Bool) {
        (considerSafeArea ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor)
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
    }
    
    func pinLeadingEdge(_ view: UIView, constant: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
    }
    
    func pinTrailingEdge(_ view: UIView, constant: CGFloat = 0) {
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant).isActive = true
    }
    
    func constraintWidth(to width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func constraintHeight(to height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
