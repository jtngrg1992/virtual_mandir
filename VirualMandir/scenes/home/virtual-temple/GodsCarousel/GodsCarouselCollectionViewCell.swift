//
//  GodsCarouselCollectionViewCell.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit

class GodsCarouselCollectionViewCell: CollectionViewCell {
    static let reuseID: String = "godCarouselCell"
    
    private var godImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public var god: God? {
        didSet {
            updateGod()
        }
    }
    
    private func updateGod() {
        godImageView.image = god?.image
    }
    
    override func setup() {
        
    }
}
