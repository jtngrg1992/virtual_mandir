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
    
    func pinTopEdge(_ view: UIView, considerSafeArea: Bool, constant: CGFloat = 0) {
        (considerSafeArea ? safeAreaLayoutGuide.topAnchor : topAnchor)
            .constraint(equalTo: view.topAnchor, constant: constant)
            .isActive = true
    }
    
    func pinBottomEdge(_ view: UIView, considerSafeArea: Bool, constant: CGFloat = 0) {
        (considerSafeArea ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor)
            .constraint(equalTo: view.bottomAnchor, constant: constant)
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
    
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint: CGPoint = CGPoint(x: bounds.size.width * point.x,
                                        y: bounds.size.height * point.y)
        var oldPoint: CGPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
    
    func centerHorizontallyInContainer(_ offset: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset).isActive = true
    }
    
    func centerVerticallyInContainer() {
        guard let superview = superview else {
            return
        }
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
}
