//
//  AnimatedBell.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 14/04/22.
//

import UIKit

protocol AnimatedBellViewing: OscillatorView {}

class AnimatedBell: OscillatorView, AnimatedBellViewing {
    
    private var bellImage: UIImageView = {
        let bellImage = UIImage(named: "hanging_bell")
        let imageView = UIImageView(image: bellImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        return imageView
    }()
    
    override func setup() {
        addSubview(bellImage)
        let imageAR: CGFloat = bellImage.image!.size.width/bellImage.image!.size.height
        
        let constraintWidth: CGFloat = 65
        let constraintHeight: CGFloat = constraintWidth/imageAR
        
        bellImage.constraintWidth(to: constraintWidth)
        bellImage.constraintHeight(to: constraintHeight)
        pinHorizontally(bellImage)
        pinVertically(bellImage)
        super.setup()
    }
}
