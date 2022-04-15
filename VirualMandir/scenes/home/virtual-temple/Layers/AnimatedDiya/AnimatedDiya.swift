//
//  AnimatedDiya.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

class AnimatedDiya: View {
    private var animatedFlame: AnimatedFlaming = {
        let flame = AnimatedFlameBuilder.build(withAssetName: "flame", frameRate: 9)
        flame.translatesAutoresizingMaskIntoConstraints = false
        return flame
    }()
    
    private var diyaImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "diya_extinguished"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override func setup() {
        addSubview(diyaImage)
        diyaImage.constraintWidth(to: 150)
        pinBottomEdge(diyaImage, considerSafeArea: false)
        pinHorizontally(diyaImage)
        
        addSubview(animatedFlame)
        animatedFlame.constraintWidth(to: 38 * 0.5)
        animatedFlame.constraintHeight(to: 84 * 0.5)
        animatedFlame.centerHorizontallyInContainer(46)
        pinBottomEdge(animatedFlame, considerSafeArea: false, constant: 45)
        
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    public func lightUp() {
        animatedFlame.layer.opacity = 0
        animatedFlame.startAnimating()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.animatedFlame.layer.opacity = 1
        }        
    }
}
