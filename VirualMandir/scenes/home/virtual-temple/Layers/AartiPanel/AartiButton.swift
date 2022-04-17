//
//  AartiButton.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 16/04/22.
//

import UIKit


protocol AartiButtonInterface: InteractionsPanelButton {
    func updateAartiProgress(to value: CGFloat)
    func switchToPause()
    func switchToPlay()
}

class AartiButton: InteractionsPanelButton, AartiButtonInterface {
    
    let progressLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.lineWidth = 2
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor.white.cgColor
        return shapeLayer
    }()
    
    private let pauseImage: UIImage? = MandirInteraction.pauseAarti.interactionThumbnail?.withRenderingMode(.alwaysTemplate)
    private let playImage: UIImage? = MandirInteraction.playAarti.interactionThumbnail?.withRenderingMode(.alwaysTemplate)
    private let playTitle: String = MandirInteraction.playAarti.interactionLocalizedTitle
    private let pauseTitle: String = MandirInteraction.pauseAarti.interactionLocalizedTitle
    
    lazy var progressPath: UIBezierPath = {
        let progressStartPoint: CGFloat = (.pi * 3/2)
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2),
                                radius: bounds.width/2 - 4,
                                startAngle: -CGFloat.pi/2,
                                endAngle: 3 * CGFloat.pi/2,
                                clockwise: true)
        return path
    }()
    
    override func setup() {
        super.setup()
        
        setContent(title: playTitle, image: playImage)
        imageView.tintColor = .white
        
        constraintWidth(to: 80)
        constraintHeight(to: 80)
        
        imageWidthConstraint.isActive = false
        imageHeightConstriant.isActive = false
        contentStack.spacing = 5
        
        superview?.layoutIfNeeded()
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.frame = bounds
        progressLayer.path = progressPath.cgPath
    }
    
    func updateAartiProgress(to value: CGFloat) {
        progressLayer.strokeEnd = value
    }
    
    func switchToPlay() {
        setContent(title: playTitle, image: playImage)
    }
    
    func switchToPause() {
        setContent(title: pauseTitle, image: pauseImage)
    }
}
