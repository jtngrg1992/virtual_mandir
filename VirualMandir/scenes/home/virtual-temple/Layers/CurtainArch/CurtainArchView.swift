//
//  CurtainArchView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit

protocol CurtainArchViewing: VirtualMandirLayer {}

/// This represents the Arch with red curtain that you see in the mandir

class CurtainArchView: View, CurtainArchViewing {
    
    private var archImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "curtain_arch"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.layer.shadowRadius = 3
        img.layer.shadowOpacity = 0.5
        img.layer.shadowOffset = CGSize(width: 0, height: 10)
        return img
    }()
    
    override func setup() {
        addSubview(archImageView)
        pinTopEdge(archImageView, considerSafeArea: false)
        pinBottomEdge(archImageView, considerSafeArea: false)
        pinLeadingEdge(archImageView, constant: 8)
        pinTrailingEdge(archImageView, constant: -8)
        archImageView.constraintHeight(to: calculateArchImageHeight())
        isUserInteractionEnabled = false
    }
    
    private func calculateArchImageHeight() -> CGFloat {
        let archImageWidth = UIScreen.main.bounds.width + 16
        let aspectRatio: CGFloat = 1.27
        let height = archImageWidth/aspectRatio
        return height
    }
}

extension CurtainArchView {
    func layoutYourselfOutInContainer() {
        guard let superview = superview else {
            return
        }
        superview.pinTopEdge(self, considerSafeArea: false)
        superview.pinHorizontally(self)
    }
}
