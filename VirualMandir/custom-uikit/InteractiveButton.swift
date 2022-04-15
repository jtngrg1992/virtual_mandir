//
//  InteractiveButton.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

class InteractiveButton: UIControl {
    
    let dashBorder = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(CustomUIKitError.initCoderNotImplemented.localizedDescription)
    }
    
    open func setup() {
        layer.addSublayer(dashBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height/2
        
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        
        
        dashBorder.lineWidth = 2
        dashBorder.strokeColor = UIColor.white.cgColor
        dashBorder.lineDashPattern = [5, 3]
        dashBorder.lineCap = .round
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateTransform {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateTransform {
            self.transform = .identity
        }
        sendActions(for: .valueChanged)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateTransform {
            self.transform = .identity
        }
    }
    
    private func animateTransform(_ transformClosure: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [.curveEaseInOut, .allowUserInteraction]) {
            transformClosure()
        }
    }
}
